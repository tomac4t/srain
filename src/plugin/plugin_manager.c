/* Copyright (C) 2016-2020 Shengyu Zhang <i@silverrainz.me>
 *
 * This file is part of Srain.
 *
 * Srain is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */


#include <gtk/gtk.h>
#include <girepository.h>
#include <libpeas/peas.h>
#include <libpeas-gtk/peas-gtk.h>

#include "plugin/plugin_manager.h"

#include "i18n.h"

struct _SrnPluginManager {
    PeasGtkPluginManager parent;
};

struct _SrnPluginManagerClass {
    PeasGtkPluginManagerClass parent_class;
};

G_DEFINE_TYPE(SrnPluginManager, srn_plugin_manager, PEAS_GTK_TYPE_PLUGIN_MANAGER);

SrnPluginManager* srn_plugin_manager_new(void){
    return g_object_new(SRN_TYPE_PLUGIN_MANAGER,
            "engine", peas_engine_get_default(),
            NULL);
}

static void srn_plugin_manager_init(SrnPluginManager *self) {
}

static void srn_plugin_manager_class_init(SrnPluginManagerClass *class) {
}
