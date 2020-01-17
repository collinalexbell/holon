

/* libUIOHook: Cross-platfrom userland keyboard and mouse hooking.
 * Copyright (C) 2006-2016 Alexander Barker.  All Rights Received.
 * https://github.com/kwhat/libuiohook/
 *
 * libUIOHook is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published
 * by the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * libUIOHook is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <set>
#include <unistd.h>
#include <inttypes.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdio.h>
#include <string.h>
#include <uiohook.h>

int NUM_KEY_CODES = 5;

struct HotCombo {
	//More than a 5 key hotkey would be insane
	char *name;
	std::set<int> key_codes;
};

struct HotCombo combos[50];
int num_combos = 0;
//Seriously, do not be a freak. 500 key keyboards only
//...else falling asleep on the board = SEGFAULT!
std::set<int> currently_pressed;

void add_combo(char *name, std::set<int> key_codes){
	combos[num_combos] = (HotCombo){name, key_codes};
	num_combos++;
}


bool logger_proc(unsigned int level, const char *format, ...) {
	bool status = false;
	
	va_list args;
	switch (level) {
		#ifdef USE_DEBUG
		case LOG_LEVEL_DEBUG:
		case LOG_LEVEL_INFO:
			va_start(args, format);
			status = vfprintf(stdout, format, args) >= 0;
			va_end(args);
			break;
		#endif

		case LOG_LEVEL_WARN:
		case LOG_LEVEL_ERROR:
			va_start(args, format);
			status = vfprintf(stderr, format, args) >= 0;
			va_end(args);
			break;
	}
	
	return status;
}

void handle_keypress_event(uiohook_event * const event){
	if(event->type == EVENT_KEY_PRESSED){
		currently_pressed.insert(event->data.keyboard.keycode);
	}
	if(event->type == EVENT_KEY_RELEASED){
		currently_pressed.erase(event->data.keyboard.keycode);
	}
	for(int i = 0; i<num_combos; i++){
			auto found = combos[i].key_codes.find(event->data.keyboard.keycode);
			//Only print if a required key was just pressed or released
			if(found != combos[i].key_codes.end()){
				int not_pressed_count = 0;
				for(auto j=combos[i].key_codes.begin(); j!=combos[i].key_codes.end(); j++){
					if(currently_pressed.find(*j) == currently_pressed.end()){
						not_pressed_count++;
					}
				}
				if((not_pressed_count == 0) && (event->type == EVENT_KEY_PRESSED)){
						printf("{:event :combo-pressed :name :%s}\n", combos[i].name);
					}
				if((not_pressed_count ==1) && (event->type == EVENT_KEY_RELEASED)){
						printf("{:event :combo-released :name :%s}\n", combos[i].name);
				}
			}
		}
}



int start_hook(){
	// Set the logger callback for library output.
	hook_set_logger_proc(&logger_proc);
	

	// Set the event callback for uiohook events.
	hook_set_dispatch_proc(handle_keypress_event);
	
	// Start the hook and block.
	// NOTE If EVENT_HOOK_ENABLED was delivered, the status will always succeed.
	int status = hook_run();
	switch (status) {
		case UIOHOOK_SUCCESS:
			// Everything is ok.
			break;

		// System level errors.
		case UIOHOOK_ERROR_OUT_OF_MEMORY:
			logger_proc(LOG_LEVEL_ERROR, "Failed to allocate memory. (%#X)", status);
			break;


		// X11 specific errors.
		case UIOHOOK_ERROR_X_OPEN_DISPLAY:
			logger_proc(LOG_LEVEL_ERROR, "Failed to open X11 display. (%#X)", status);
			break;

		case UIOHOOK_ERROR_X_RECORD_NOT_FOUND:
			logger_proc(LOG_LEVEL_ERROR, "Unable to locate XRecord extension. (%#X)", status);
			break;

		case UIOHOOK_ERROR_X_RECORD_ALLOC_RANGE:
			logger_proc(LOG_LEVEL_ERROR, "Unable to allocate XRecord range. (%#X)", status);
			break;

		case UIOHOOK_ERROR_X_RECORD_CREATE_CONTEXT:
			logger_proc(LOG_LEVEL_ERROR, "Unable to allocate XRecord context. (%#X)", status);
			break;

		case UIOHOOK_ERROR_X_RECORD_ENABLE_CONTEXT:
			logger_proc(LOG_LEVEL_ERROR, "Failed to enable XRecord context. (%#X)", status);
			break;

			
		// Windows specific errors.
		case UIOHOOK_ERROR_SET_WINDOWS_HOOK_EX:
			logger_proc(LOG_LEVEL_ERROR, "Failed to register low level windows hook. (%#X)", status);
			break;


		// Darwin specific errors.
		case UIOHOOK_ERROR_AXAPI_DISABLED:
			logger_proc(LOG_LEVEL_ERROR, "Failed to enable access for assistive devices. (%#X)", status);
			break;

		case UIOHOOK_ERROR_CREATE_EVENT_PORT:
			logger_proc(LOG_LEVEL_ERROR, "Failed to create apple event port. (%#X)", status);
			break;

		case UIOHOOK_ERROR_CREATE_RUN_LOOP_SOURCE:
			logger_proc(LOG_LEVEL_ERROR, "Failed to create apple run loop source. (%#X)", status);
			break;

		case UIOHOOK_ERROR_GET_RUNLOOP:
			logger_proc(LOG_LEVEL_ERROR, "Failed to acquire apple run loop. (%#X)", status);
			break;

		case UIOHOOK_ERROR_CREATE_OBSERVER:
			logger_proc(LOG_LEVEL_ERROR, "Failed to create apple run loop observer. (%#X)", status);
			break;

		// Default error.
		case UIOHOOK_FAILURE:
		default:
			logger_proc(LOG_LEVEL_ERROR, "An unknown hook error occurred. (%#X)", status);
			break;
	}

	return status;
}

int main() {
	//For now, just hard code the combo
	std::set<int> keys{3675, 56};
	add_combo("dameon-listen", keys);

	start_hook();
}
