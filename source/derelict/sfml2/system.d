/*

Boost Software License - Version 1.0 - August 17th, 2003

Permission is hereby granted, free of charge, to any person or organization
obtaining a copy of the software and accompanying documentation covered by
this license ( the "Software") to use, reproduce, display, distribute,
execute, and transmit the Software, and to prepare derivative works of the
Software, and to permit third-parties to whom the Software is furnished to
do so, all subject to the following:

The copyright notices in the Software and this entire statement, including
the above license grant, this restriction and the following disclaimer,
must be included in all copies of the Software, in whole or in part, and
all derivative works of the Software, unless such copies or derivative
works are solely in the form of machine-executable object code generated by
a source language processor.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

*/
module derelict.sfml2.system;

public import derelict.util.loader;

private {
    import derelict.util.system;

    static if(  Derelict_OS_Windows )
        enum libNames = "csfml-system.dll,csfml-system-2.dll,csfml-system-2.3.dll";
    else static if(  Derelict_OS_Mac )
        enum libNames = "libcsfml-system.dylib,libcsfml-system.2.dylib,libcsfml-system.2.3.dylib";
    else static if(  Derelict_OS_Posix )
        enum libNames = "libcsfml-system.so,libcsfml-system.so.2,libcsfml-system.so.2.3";
    else
        static assert(  0, "Need to implement SFML2 System libNames for this operating system." );
}

// Config.h
enum CSFML_VERSION_MAJOR = 2;
enum CSFML_VERSION_MINOR = 1;

alias sfBool = int;
enum sfFalse = 0;
enum sfTrue = 1;

alias sfInt8 = byte;
alias sfUint8 = ubyte;
alias sfInt16 = short;
alias sfUint16 = ushort;
alias sfInt32 = int;
alias sfUint32 = uint;
alias sfInt64 = long;
alias sfUint64 = ulong;

// System/Types.h
struct sfClock;
struct sfMutex;
struct sfThread;

// System/InputStream.h
extern( C) nothrow {
    alias sfInputStreamReadFunc = sfInt64 function(  void*,sfInt64,void* );
    alias sfInputStreamSeekFunc = sfInt64 function(  sfInt64,void* );
    alias sfInputStreamTellFunc = sfInt64 function(  void* );
    alias sfInputStreamGetSizeFunc = sfInt64 function(  void* );
}

struct sfInputStream {
    sfInputStreamReadFunc read;
    sfInputStreamSeekFunc seek;
    sfInputStreamTellFunc tell;
    sfInputStreamGetSizeFunc getSize;
    void* userData;
}

// System/Time.h
struct sfTime {
    sfInt64 microseconds;
}

immutable(  sfTime ) sfTime_Zero;

// System/Vector2.h
struct sfVector2i {
    int x;
    int y;
}

struct sfVector2u {
    uint x;
    uint y;
}

struct sfVector2f {
    float x;
    float y;
}

// System/Vector3.h
struct sfVector3f {
    float x;
    float y;
    float z;
}

extern( C) @nogc nothrow {
    // System/Clock.h
    alias da_sfClock_create = sfClock* function(  );
    alias da_sfClock_copy = sfClock* function( const( sfClock )* );
    alias da_sfClock_destroy = void function( sfClock* );
    alias da_sfClock_getElapsedTime = sfTime function( const( sfClock* ));
    alias da_sfClock_restart = sfTime function( sfClock* );

    // System/Mutex.h
    alias da_sfMutex_create = sfMutex* function(  );
    alias da_sfMutex_destroy = void function( sfMutex* );
    alias da_sfMutex_lock = void function( sfMutex* );
    alias da_sfMutex_unlock = void function( sfMutex* );

    // System/Sleep.h
    alias da_sfSleep = void function( sfTime );

    // System/Thread.h
    alias da_sfThread_create = sfThread* function( void function( void* ),void* );
    alias da_sfThread_destroy = void function( sfThread* );
    alias da_sfThread_launch = void function( sfThread* );
    alias da_sfThread_wait = void function( sfThread* );
    alias da_sfThread_terminate = void function( sfThread* );

    // System/Time.h
    alias da_sfTime_asSeconds = float function( sfTime );
    alias da_sfTime_asMilliseconds = sfInt32 function( sfTime );
    alias da_sfTime_asMicroseconds = sfInt64 function( sfTime );
    alias da_sfSeconds = sfTime function( float );
    alias da_sfMilliseconds = sfTime function( sfInt32 );
    alias da_sfMicroseconds = sfTime function( sfInt64 );
}

__gshared {
    da_sfClock_create sfClock_create;
    da_sfClock_copy sfClock_copy;
    da_sfClock_destroy sfClock_destroy;
    da_sfClock_getElapsedTime sfClock_getElapsedTime;
    da_sfClock_restart sfClock_restart;
    da_sfMutex_create sfMutex_create;
    da_sfMutex_destroy sfMutex_destroy;
    da_sfMutex_lock sfMutex_lock;
    da_sfMutex_unlock sfMutex_unlock;
    da_sfSleep sfSleep;
    da_sfThread_create sfThread_create;
    da_sfThread_destroy sfThread_destroy;
    da_sfThread_launch sfThread_launch;
    da_sfThread_wait sfThread_wait;
    da_sfThread_terminate sfThread_terminate;
    da_sfTime_asSeconds sfTime_asSeconds;
    da_sfTime_asMilliseconds sfTime_asMilliseconds;
    da_sfTime_asMicroseconds sfTime_asMicroseconds;
    da_sfSeconds sfSeconds;
    da_sfMilliseconds sfMilliseconds;
    da_sfMicroseconds sfMicroseconds;
}

class DerelictSFML2SystemLoader : SharedLibLoader {
    public this() {
        super(libNames );
    }

    protected override void loadSymbols() {
        bindFunc( cast( void** )&sfClock_create, "sfClock_create" );
        bindFunc( cast( void** )&sfClock_copy, "sfClock_copy" );
        bindFunc( cast( void** )&sfClock_destroy, "sfClock_destroy" );
        bindFunc( cast( void** )&sfClock_getElapsedTime, "sfClock_getElapsedTime" );
        bindFunc( cast( void** )&sfClock_restart, "sfClock_restart" );
        bindFunc( cast( void** )&sfMutex_create, "sfMutex_create" );
        bindFunc( cast( void** )&sfMutex_destroy, "sfMutex_destroy" );
        bindFunc( cast( void** )&sfMutex_lock, "sfMutex_lock" );
        bindFunc( cast( void** )&sfMutex_unlock, "sfMutex_unlock" );
        bindFunc( cast( void** )&sfSleep, "sfSleep" );
        bindFunc( cast( void** )&sfThread_create, "sfThread_create" );
        bindFunc( cast( void** )&sfThread_destroy, "sfThread_destroy" );
        bindFunc( cast( void** )&sfThread_launch, "sfThread_launch" );
        bindFunc( cast( void** )&sfThread_wait, "sfThread_wait" );
        bindFunc( cast( void** )&sfThread_terminate, "sfThread_terminate" );
        bindFunc( cast( void** )&sfTime_asSeconds, "sfTime_asSeconds" );
        bindFunc( cast( void** )&sfTime_asMilliseconds, "sfTime_asMilliseconds" );
        bindFunc( cast( void** )&sfTime_asMicroseconds, "sfTime_asMicroseconds" );
        bindFunc( cast( void** )&sfSeconds, "sfSeconds" );
        bindFunc( cast( void** )&sfMilliseconds, "sfMilliseconds" );
        bindFunc( cast( void** )&sfMicroseconds, "sfMicroseconds" );
    }
}

__gshared DerelictSFML2SystemLoader DerelictSFML2System;

shared static this() {
    DerelictSFML2System = new DerelictSFML2SystemLoader();
}
