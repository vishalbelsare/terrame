-------------------------------------------------------------------------------------------
-- TerraME - a software platform for multiple scale spatially-explicit dynamic modeling.
-- Copyright (C) 2001-2016 INPE and TerraLAB/UFOP -- www.terrame.org

-- This code is part of the TerraME framework.
-- This framework is free software; you can redistribute it and/or
-- modify it under the terms of the GNU Lesser General Public
-- License as published by the Free Software Foundation; either
-- version 2.1 of the License, or (at your option) any later version.

-- You should have received a copy of the GNU Lesser General Public
-- License along with this library.

-- The authors reassure the license terms regarding the warranties.
-- They specifically disclaim any warranties, including, but not limited to,
-- the implied warranties of merchantability and fitness for a particular purpose.
-- The framework provided hereunder is on an "as is" basis, and the authors have no
-- obligation to provide maintenance, support, updates, enhancements, or modifications.
-- In no event shall INPE and TerraLAB / UFOP be held liable to any party for direct,
-- indirect, special, incidental, or consequential damages arising out of the use
-- of this software and its documentation.
--
-------------------------------------------------------------------------------------------

return{
 	Project = function(unitTest)
 		local noDataInContructor = function()
 			local proj = Project()
 		end
 		unitTest:assertError(noDataInContructor, tableArgumentMsg())

		local attrFileNonString = function()
			local proj = Project{file = 123}
		end
		unitTest:assertError(attrFileNonString, incompatibleTypeMsg("file", "string", 123))

		local attrFileNonString = function()
			local proj = Project{file = "abc", author = "<no author>"}
		end
		unitTest:assertError(attrFileNonString, defaultValueMsg("author", "<no author>"))

		local attrCreateNonBool = function()
			local proj = Project{file = "myproj.tview", clean = 2}
		end
		unitTest:assertError(attrCreateNonBool, incompatibleTypeMsg("clean", "boolean", 2))

		local attrTitleNonString = function()
			local proj = Project{file = "myproj.tview", title = 2}
		end
		unitTest:assertError(attrTitleNonString, incompatibleTypeMsg("title", "string", 2))		

		local attrAuthorNonString = function()
			local proj = Project{file = "myproj.tview", author = 2}
		end
		unitTest:assertError(attrAuthorNonString, incompatibleTypeMsg("author", "string", 2))				
		local fileMandatory = function()
			local proj = Project{clean = true}
		end
		unitTest:assertError(fileMandatory, mandatoryArgumentMsg("file"))

		local unnecessaryArgument = function()
			local proj = Project{file = "myproj.tview", cean = true}
		end
		unitTest:assertError(unnecessaryArgument, unnecessaryArgumentMsg("cean", "clean"))
 	end
}
