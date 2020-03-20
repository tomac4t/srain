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

#ifndef __PLUGIN_H
#define __PLUGIN_H

#include <glib-object.h>

/*
 * Type checking and casting macros
 */
#define SRN_TYPE_PLUGIN            (srn_plugin_get_type())
#define SRN_PLUGIN(obj)            (G_TYPE_CHECK_INSTANCE_CAST((obj), SRN_TYPE_PLUGIN, SrnPlugin))
#define SRN_PLUGIN_CLASS(klass)    (G_TYPE_CHECK_CLASS_CAST((klass), SRN_TYPE_PLUGIN, SrnPluginClass))
#define SRN_IS_PLUGIN(obj)         (G_TYPE_CHECK_INSTANCE_TYPE((obj), SRN_TYPE_PLUGIN))
#define SRN_IS_PLUGIN_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), SRN_TYPE_PLUGIN))
#define SRN_PLUGIN_GET_CLASS(obj)  (G_TYPE_INSTANCE_GET_CLASS((obj), SRN_TYPE_PLUGIN, SrnPluginClass))

typedef struct _SrnPlugin SrnPlugin;
typedef struct _SrnPluginClass SrnPluginClass;

GType srn_plugin_get_type(void);
SrnPlugin *srn_plugin_new(void);

#endif /* __PLUGIN_H */
