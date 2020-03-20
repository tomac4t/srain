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

#include "plugin.h"

struct _SrnPlugin {
    GObject parent;
};

struct _SrnPluginClass {
    GObjectClass parent_class;
};

G_DEFINE_TYPE(SrnPlugin, srn_plugin, G_TYPE_OBJECT);

SrnPlugin* srn_plugin_new(void){
    return g_object_new(SRN_TYPE_PLUGIN, NULL);
}

static void srn_plugin_init(SrnPlugin *self) {
}

static void srn_plugin_class_init(SrnPluginClass *class) {
}
