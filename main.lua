------------------------------------------------------------------------------------------------
-- Example of use Physics Editor exporter for Corona SDK
--
-- @script  main
-- @author Łukasz Durniat
-- @license MIT
-- @copyright Łukasz Durniat, May-2018
------------------------------------------------------------------------------------------------

-- ------------------------------------------------------------------------------------------ --
--                                 REQUIRED MODULES	                                          --						
-- ------------------------------------------------------------------------------------------ --

local composer    = require( "composer" ) 
local physics     = require( "physics" )
local physicsData = ( require "bodies" ).physicsData()
--local physicsData = ( require "bodies" ).physicsData( 1 )
--local physicsData = ( require "bodies" ).physicsData( 1, 0.5 )
--local physicsData = ( require "bodies" ).physicsData( 0.5, 1 )

-- ------------------------------------------------------------------------------------------ --
--                                 LOCALISED VARIABLES                                        --	
-- ------------------------------------------------------------------------------------------ --

-- ------------------------------------------------------------------------------------------ --
--                                 PRIVATE METHODS                                            --	
-- ------------------------------------------------------------------------------------------ --

-- ------------------------------------------------------------------------------------------ --
--                                 PUBLIC METHODS                                             --	
-- ------------------------------------------------------------------------------------------ --

-- Init physics
physics.start()
physics.setDrawMode( "hybrid" )

local names  = { "shield", "heart" }
local coords = { ["shield"]={ x=100, y=200 }, ["heart"]={ x=200, y=200 } }

-- Create shield and heart images
for i=1, #names do

	local name       = names[i]
	local image      = display.newImage( name .. ".png" )
	image.x, image.y = coords[name].x, coords[name].y
	physics.addBody( image, "static", physicsData:get( name ) )

end
