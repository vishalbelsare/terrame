/************************************************************************************
TerraME - a software platform for multiple scale spatially-explicit dynamic modeling.
Copyright (C) 2001-2017 INPE and TerraLAB/UFOP -- www.terrame.org

This code is part of the TerraME framework.
This framework is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

You should have received a copy of the GNU Lesser General Public
License along with this library.

The authors reassure the license terms regarding the warranties.
They specifically disclaim any warranties, including, but not limited to,
the implied warranties of merchantability and fitness for a particular purpose.
The framework provided hereunder is on an "as is" basis, and the authors have no
obligation to provide maintenance, support, updates, enhancements, or modifications.
In no event shall INPE and TerraLAB / UFOP be held liable to any party for direct,
indirect, special, incidental, or consequential damages arising out of the use
of this software and its documentation.
*************************************************************************************/

#ifndef QGS_WRITER_H
#define QGS_WRITER_H

class QDomDocument;
class QDomElement;

#include "QGisProject.h"
#include "QGisLayer.h"

namespace terrame
{
	namespace qgis
	{
		class QgsWriter
		{
		public:
			void addLayers(const terrame::qgis::QGisProject& qgp,
					const std::vector<terrame::qgis::QGisLayer>& layers);
			void removeLayers(const terrame::qgis::QGisProject& qgp,
					const std::vector<terrame::qgis::QGisLayer>& layers);
			void create(const terrame::qgis::QGisProject& qgp);

		private:
			void addLayers(QDomDocument& doc,
						const std::string& qgsfile,
						const std::vector<terrame::qgis::QGisLayer>& layers);
			void removeLayers(QDomDocument& doc,
						const std::vector<terrame::qgis::QGisLayer>& layers);
			QDomDocument createDocument(const std::string& filepath);
			std::string getRelativePath(const std::string& path,
											const std::string& relative);
			int occurrences(const std::string& str, const std::string& substring);
			QDomElement createTextElement(QDomDocument& doc, const std::string& element,
									const std::string& content);
			QDomElement createSpatialRefSysElement(QDomDocument& doc,
											const terrame::qgis::QGisLayer& layer);
			QDomElement createExtentElement(QDomDocument& doc,
											const terrame::qgis::QGisLayer& layer);
			std::string genLayerId(const terrame::qgis::QGisLayer& layer);
			void save(QDomDocument& doc, const std::string& qgspath);
			std::string toString(double number);
		};
	} // namespace qgis
} // namespace terrame

#endif
