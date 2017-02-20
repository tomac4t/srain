#ifndef __SUI_H
#define __SUI_H

#include "srain_msg.h"
#include "srain_user_list.h"

typedef struct _SuiSession SuiSession;
typedef int SuiSessionFlag;

#define SUI_SESSION_SERVER      1 >> 0
#define SUI_SESSION_CHANNEL     1 >> 1
#define SUI_SESSION_DIALOG      1 >> 2
#define SUI_SESSION_NEWWINDOW   1 >> 3 // Not used yet
#define SUI_SESSION_NOSWITCH    1 >> 4 // Not used yet

#include "sui_event.h"

void sui_main_loop(int argc, char **argv);
SuiSession *sui_new_session(const char *name, const char *remark, SuiEvents *events, SuiSessionFlag flag);
void sui_free_session(SuiSession *sui);
SuiEvents *sui_get_events(SuiSession *sui);
void* sui_get_ctx(SuiSession *sui);
void sui_set_ctx(SuiSession *sui, void *ctx);

void sui_add_sys_msg(SuiSession *sui, const char *msg, SysMsgType type, SrainMsgFlag flag);
void sui_add_sys_msgf(SuiSession *sui, SysMsgType type, SrainMsgFlag flag,
        const char *fmt, ...);
void ui_add_sent_msg(SuiSession *sui, const char *msg, SrainMsgFlag flag);
void sui_add_recv_msg(SuiSession *sui, const char *nick, const char *id,
        const char *msg, SrainMsgFlag flag);

int sui_add_user(SuiSession *sui, const char *nick, UserType type);
int sui_rm_user(SuiSession *sui, const char *nick);
void sui_ren_user(SuiSession *sui, const char *old_nick, const char *new_nick, UserType type);
void sui_set_topic(SuiSession *sui, const char *topic);

#endif /* __SUI_H */
