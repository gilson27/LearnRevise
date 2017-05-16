#ifndef _CAPP_H_
    #define _CAPP_H_
 
#include <SDL.h>
 
class CApp {
 
    public:
 
        CApp();
 
        int OnExecute();

    public:
 
        bool OnInit();
 
        void OnEvent(SDL_Event* Event);
 
        void OnLoop();
 
        void OnRender();
 
        void OnCleanup();
};
 
#endif