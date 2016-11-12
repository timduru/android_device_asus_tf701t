/*
 * Copyright (c) 2011-2012 NVIDIA Corporation.  All Rights Reserved.
 *
 * NVIDIA Corporation and its licensors retain all intellectual property and
 * proprietary rights in and to this software and related documentation.  Any
 * use, reproduction, disclosure or distribution of this software and related
 * documentation without an express license agreement from NVIDIA Corporation
 * is strictly prohibited.
 */
#ifndef POWER_HAL_TIMEOUT_POKER_H
#define POWER_HAL_TIMEOUT_POKER_H

#include <stdint.h>
#include <sys/types.h>

#include <utils/threads.h>
#include <utils/Errors.h>
#include <utils/List.h>
#include <utils/Looper.h>
#include <utils/Log.h>

#include "barrier.h"

//It seems redundant to need both this message queue
//And the IPC threads message queue
//But I didn't see an easy way to
//run an event after a timeout on the IPC threads

using namespace android;

class TimeoutPoker {
private:
    class PokeHandler;

public:
    TimeoutPoker(Barrier* readyToRun);

    int createPmQosHandle(const char* filename, int val);
    int requestPmQos(const char* filename, int val);
    void requestPmQosTimed(const char* filename, int val, nsecs_t timeoutNs);

private:
    class QueuedEvent {
    public:
        virtual ~QueuedEvent() {}
        QueuedEvent() { }

        virtual void run(PokeHandler * const thiz) = 0;
    };

    class PmQosOpenTimedEvent : public QueuedEvent {
    public:
        virtual ~PmQosOpenTimedEvent() {}
        PmQosOpenTimedEvent(const char* node,
                int val,
                nsecs_t timeout) :
            node(node),
            val(val),
            timeout(timeout) { }

        virtual void run(PokeHandler * const thiz) {
            thiz->openPmQosTimed(node, val, timeout);
        }

    private:
        const char* node;
        int val;
        nsecs_t timeout;
    };

    class PmQosOpenHandleEvent : public QueuedEvent {
    public:
        virtual ~PmQosOpenHandleEvent() {}
        PmQosOpenHandleEvent(const char* node,
                int val,
                int* outFd,
                Barrier* done) :
            node(node),
            val(val),
            outFd(outFd),
            done(done) { }

        virtual void run(PokeHandler * const thiz) {
            *outFd = thiz->createHandleForPmQosRequest(node, val);
            done->open();
        }

    private:
        const char* node;
        int val;
        int* outFd;
        Barrier* done;
    };

    class TimeoutEvent : public QueuedEvent {
    public:
        virtual ~TimeoutEvent() {}
        TimeoutEvent(int pmQosFd) : pmQosFd(pmQosFd) {}

        virtual void run(PokeHandler * const thiz) {
            thiz->timeoutRequest(pmQosFd);
        }

    private:
        int pmQosFd;
    };

    void pushEvent(QueuedEvent* event);

    class PokeHandler : public MessageHandler {
        class LooperThread : public Thread {
            private:
                Barrier* mReadyToRun;
            public:
                sp<Looper> mLooper;
                virtual bool threadLoop();
                LooperThread(Barrier* readyToRun) :
                    mReadyToRun(readyToRun) {}
                virtual status_t readyToRun();
        };
    public:

        sp<LooperThread> mWorker;

        KeyedVector<unsigned int, QueuedEvent*> mQueuedEvents;

        virtual void handleMessage(const Message& msg);
        PokeHandler(TimeoutPoker* poker, Barrier* readyToRun);
        int generateNewKey(void);
        void sendEventDelayed(nsecs_t delay, QueuedEvent* ev);
        int listenForHandleToCloseFd(int handle, int fd);
        QueuedEvent* removeEventByKey(int key);
        void openPmQosTimed(const char* fileName, int val, nsecs_t timeout);
        int createHandleForFd(int fd);
        int createHandleForPmQosRequest(const char* filename, int val);
        int openPmQosNode(const char* filename, int val);
        void timeoutRequest(int fd);
    private:
        TimeoutPoker* mPoker;
        int mKey;

        bool mSpamRefresh;
        mutable Mutex mEvLock;
    };

    sp<PokeHandler> mPokeHandler;
};

#endif
