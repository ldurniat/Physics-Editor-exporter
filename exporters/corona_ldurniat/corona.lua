-- File modified by Łukasz Durniat
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
        data = { {% for body in bodies %}
            {% if not forloop.first %}, {% endif %}
            ["{{body.name}}"] = {
                        {% for fixture in body.fixtures %}
                        {% if not forloop.first %} ,{% endif %}
                        {% if fixture.isCircle %}
                        {
                            pe_fixture_id = "{{fixture.pe_fixture_id}}", density = {{fixture.density}}, friction = {{fixture.friction}}, bounce = {{fixture.bounce}}, {% if fixture.isSensor %}isSensor=true, {% endif %}
                            filter = { categoryBits = {{fixture.filter_categoryBits}}, maskBits = {{fixture.filter_maskBits}}, groupIndex = {{fixture.filter_groupIndex}} },
                            radius = {{fixture.radius|floatformat:3}},
                            xScale = {{body.xScale}},
                            yScale = {{body.yScale}}
                        }
                        {% else %}
                        {% for polygon in fixture.polygons %}{% if not forloop.first %} ,{% endif %}
                        {
                            pe_fixture_id = "{{fixture.pe_fixture_id}}", density = {{fixture.density}}, friction = {{fixture.friction}}, bounce = {{fixture.bounce}}, {% if fixture.isSensor %}isSensor=true, {% endif %}
                            filter = { categoryBits = {{fixture.filter_categoryBits}}, maskBits = {{fixture.filter_maskBits}}, groupIndex = {{fixture.filter_groupIndex}} },
                            shape = { {% for point in polygon %} {% if not forloop.first %}, {% endif %} {{point.x}}, {{point.y}} {% endfor %} },
                            xScale = {{body.xScale}},
                            yScale = {{body.yScale}}
                        }
                        {% endfor %}
                        {% endif %}
                        {% endfor %}
            }
            {% endfor %}
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

