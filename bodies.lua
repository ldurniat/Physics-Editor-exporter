-- File modified by �ukasz Durniat
-- https://github.com/ldurniat
--
-- This file is for use with Corona(R) SDK
--
-- This file is automatically generated with PhysicsEdtior (http://physicseditor.de). Do not edit
--
-- Usage example:
--
--          local scaleFactorX = 1.0
--          local scaleFactorY = 1.0
--          local physicsData = ( require "shapedefs" ).physicsData( scaleFactorX, scaleFactorY )
--          local shape = display.newImage( "objectname.png" )
--          physics.addBody( shape, physicsData:get( "objectname" ) )
--

-- Copy needed functions to local scope
local unpack = unpack
local pairs  = pairs
local ipairs = ipairs

local M = {}

function M.physicsData( xScale,yScale )

    local physics = { 
        data = { 
            
            ["heart"] = {
                        
                        
                        
                        
                        {
                            pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                            filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                            shape = {   -8, -29  ,  21, -29  ,  32, -19  ,  32, -5  ,  -2, 28  ,  -26, 6  ,  -31, -19  },
                            xScale = 0.5,
                            yScale = 1
                        }
                        
                        
                        
            }
            
            , 
            ["shield"] = {
                        
                        
                        
                        
                        {
                            pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                            filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                            shape = {   14, 26  ,  -8, 29  ,  -11, -29  ,  9, -29  ,  25, -19  ,  31, 6  },
                            xScale = 1,
                            yScale = 1
                        }
                         ,
                        {
                            pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                            filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                            shape = {   -11, -29  ,  -8, 29  ,  -29, 13  ,  -32, -8  },
                            xScale = 1,
                            yScale = 1
                        }
                        
                        
                        
            }
            
        } 
    }

    -- Code borrow from 
    -- https://stackoverflow.com/questions/17295702/how-to-scale-custom-shape-physics-body-with-physics-editor
    -- apply scale factor
    yScale = yScale or xScale
    for bi,body in pairs( physics.data ) do

        for fi,fixture in ipairs( body ) do

            if fixture.shape then
                for ci,coordinate in ipairs( fixture.shape ) do

                    if (ci%2) == 0 then

                        fixture.shape[ci] = (yScale or fixture.yScale) * coordinate

                    else

                        fixture.shape[ci] = (xScale or fixture.xScale) * coordinate

                    end

                end

            else

                fixture.radius = (xScale or fixture.xScale) * fixture.radius

            end

        end

    end
    
    function physics:get( name ) return unpack( self.data[name] ) end

    function physics:getFixtureId( name, index ) return self.data[name][index].pe_fixture_id end
    
    return physics

end

return M

