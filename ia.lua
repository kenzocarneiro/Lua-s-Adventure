Room = require("room")
Vector = require("vector")

-- IA = {Room,searchType = AStarSearch(Room,IA:nullHeuristic())}
IA = {Room}

-- Constructor
--- @param searchType function The name of the function to use
function IA:new(entity,Room,searchType)
    local ia = {}
    setmetatable(ia, self)
    self.__index = self
    ia.searchFunction = searchType
    ia.currentRoom = Room
    ia.goal = self.currentRoom.enemies[1]["pos"]
    ia.state = entity["pos"]

end

-- Returns 0 in all cases
function IA:nullHeuristic()
    return 0
end

-- Computes the distance as the crow flies between two points.
--- @param tempPos Vector The vector corresponding to the position we're examining
function IA:spaceHeuristic(tempPos)
    return #(self.goal-tempPos)
end


-- Returns the shortest path WITH NO GRID to the character
function IA:shortestPathFinder()
    local found = false
    local tempGoal = self.goal
    local stateTile = self.currentRoom.findTileWithPos(self.state)
    local path = {}
    path[1] = self.goal
    repeat
        local directoryCoeff = (tempGoal.y-self.state.y)/(tempGoal.x-self.state.x)
        --local crowFliesDist = self.spaceHeuristic(stateTile)
        local collision = false
        local goalTile = {}

        -- we check
        repeat

            if directoryCoeff > 0 then
                if tempGoal.y < self.state.y then
                    tempGoal.x = tempGoal.x - 8
                else
                    tempGoal.x = tempGoal.x + 8
                end
            else
                if tempGoal.y < self.state.y then
                    tempGoal.x = tempGoal.x + 8
                else
                    tempGoal.x = tempGoal.x - 8
                end
            end
            tempGoal.y = tempGoal.y + tempGoal.x*directoryCoeff
            goalTile = self.currentRoom.findTileWithPos(tempGoal)
            collision = self.currentRoom.tiles[goalTile[1]][goalTile[2]].collision

        until (collision or self.currentRoom.isOnTheSameTile(tempGoal,stateTile))

        -- if we got to the tile where the path searcher is, there was no collision, so we found a way !
        if self.currentRoom.isOnTheSameTile(tempGoal,stateTile) then
            -- so we leave
            found = true

        -- otherwise, too bad, we're in front of a wall and we must go around it.
        -- It is a bit dense but bare with me
        elseif collision then

            -- The description of a collision zone : four directions, which are the extreme points of the zone
            local collisionZone = {top=nil,bottom=nil,left=nil,right=nil}

            -- We initialisize each direction
            for direction=1,4 do
                -- Each direction has some coordinates, represented by a Vector. goalTile is the tile where we found the collision.
                collisionZone[direction]= goalTile
            end

            -- Contains all the tiles of the zone (ie. all the tiles next that have a collision)
            local collisionList={}

            -- The collision list will contain at least the collision we've just found
            collisionList[1]=goalTile

            -- moreCollision is used to know if we can't find collisions around all the zone
            local moreCollision = false


            -- We repeat the following until we find the whole zone
            repeat

                -- for each tile that we know is in the zone...
                for tileWithCollision in collisionList do

                    -- we get the four tiles around tileWithCollision
                    local topTile = self.currentRoom.tiles[tileWithCollision[1].x][tileWithCollision[2].y-1]
                    local bottomTile = self.currentRoom.tiles[tileWithCollision[1].x][tileWithCollision[2].y+1]
                    local leftTile = self.currentRoom.tiles[tileWithCollision[1].x-1][tileWithCollision[2].y]
                    local rightTile = self.currentRoom.tiles[tileWithCollision[1].x+1][tileWithCollision[2].y]

                    -- if topTile exists
                    if topTile then
                        -- if topTile hasn't been added to the zone yet
                        if collisionList[topTile] ~= nil then --------------
                            -- if topTile has a collision
                            if topTile.collision then
                                -- we keep searching for collisions because we may haven't found the whole zone yet
                                moreCollision = true
                                -- we add the tile to the zone
                                collisionList[#collisionList+1] = topTile
                                -- if the tile is at the extreme top on the zone, it becomes the new top
                                if collisionZone["top"].y < topTile.pixelPos.y then
                                    collisionZone["top"] = self.currentRoom.getIndexes(topTile)
                                end
                            end
                        end
                    end

                    -- same as above but for the bottom tile
                    if bottomTile then
                        if collisionList[bottomTile] ~= nil then --------------
                            if bottomTile.collision then
                                moreCollision = true
                                collisionList[#collisionList+1] = bottomTile
                                if collisionZone["bottom"].y > topTile.pixelPos.y then
                                    collisionZone["bottom"] = self.currentRoom.getIndexes(topTile)
                                end
                            end
                        end
                    end

                    -- same as above but for the left tile
                    if leftTile then
                        if collisionList[leftTile] ~= nil then --------------
                            if leftTile.collision then
                                moreCollision = true
                                collisionList[#collisionList + 1] = leftTile
                                if collisionZone["left"].x > topTile.pixelPos.x then
                                    collisionZone["left"] = self.currentRoom.getIndexes(leftTile)
                                end
                            end
                        end
                    end

                    -- same as above but for the right tile
                    if rightTile then
                        if collisionList[rightTile] ~= nil then --------------
                            if rightTile.collision then
                                moreCollision = true
                                collisionList[#collisionList + 1] = rightTile
                                if collisionZone["top"].x < topTile.pixelPos.x then
                                    collisionZone["right"] = self.currentRoom.getIndexes(rightTile)
                                end
                            end
                        end
                    end
                end

            until !moreCollision
            -- Yes ! We found the collision zone. Now, to go around it :

            local zone1 = nil
            local add1 = {coord=nil,add=0}
            local zone2 = nil
            local add2 = {coord=nil,add=0}

            if directoryCoeff <= 0 then
                if (collisionZone["left"].x > self.state.x) then
                    if (collisionZone["top"].y < self.state.y) then
                        zone1 = "top"
                        add1.coord = collisionZone["top"].x
                        add1.add = 1
                        zone2 = "left"
                        add2.coord = collisionZone["left"].y
                        add2.add = -1
                    else -- -- à voir si un else suffit et si ça n'englobe pas trop des cas auxquels je n'ai pas pensé
                        --if (collisionZone["top"].y > self.state.y > collisionZone["bottom"].y) then
                        zone1 = "top"
                        add1.coord = collisionZone["top"].y
                        add1.add = -1
                        zone2 = "bottom"
                        add2.coord = collisionZone["bottom"].x
                        add2.add = -1
                   -- else
                        --zone1 = "bottom"
                       -- zone2 = "bottom"
                    end
                elseif (collisionZone["right"].x < self.state.x) then
                    if (collisionZone["bottom"].y > self.state.y) then
                        zone1 = "bottom"
                        add1.coord = collisionZone["bottom"].x
                        add1.add = -1
                        zone2 = "right"
                        add2.coord = collisionZone["right"].y
                        add2.add = 1
                    else
                        zone1 = "top"
                        add1.coord = collisionZone["top"].x
                        add1.add = 1
                        zone2 = "bottom"
                        add2.coord = collisionZone["bottom"].x
                        add2.add = 1
                    end
                else
                    zone1 = "left"
                    add1.coord = collisionZone["left"].y
                    add1.add = -1
                    zone2 = "right"
                    add2.coord = collisionZone["right"].y
                    add2.add = -1
                end
            else
                -- same but if a >= 0
                if (collisionZone["left"].x > self.state.x) then
                    if (collisionZone["bottom"].y > self.state.y) then
                        zone1 = "left"
                        add1.coord = collisionZone["left"].y
                        add1.add = 1
                        zone2 = "bottom"
                        add2.coord = collisionZone["bottom"].x
                        add2.add = 1
                    else
                        zone1 = "top"
                        add1.coord = collisionZone["top"].x
                        add1.add = -1
                        zone2 = "bottom"
                        add2.coord = collisionZone["bottom"].x
                        add2.add = -1
                    end
                elseif (collisionZone["right"].x < self.state.x) then
                    if (collisionZone["top"].y < self.state.y) then
                        zone1 = "top"
                        add1.coord = collisionZone["top"].x
                        add1.add = -1
                        zone2 = "right"
                        add2.coord = collisionZone["right"].y
                        add2.add = -1
                    else
                        zone1 = "top"
                        add1.coord = collisionZone["top"].x
                        add1.add = 1
                        zone2 = "bottom"
                        add2.coord = collisionZone["bottom"].x
                        add2.add = 1
                    end
                else
                    zone1 = "left"
                    add1.coord = collisionZone["left"].y
                    add1.add = 1
                    zone2 = "right"
                    add2.coord = collisionZone["right"].y
                    add2.add = 1
                end
            end

            local nextDestOne = collisionZone[zone1]
            while self.currentRoom.tiles[nextDestOne.x][nextDestOne.y].collision do
                add1.coord = add1.coord + add1.add
            end

            add1.coord = add1.coord + add1.add

            -- For second path
            local nextDestTwo = collisionZone[zone2]
            while self.currentRoom.tiles[nextDestTwo.x+1][nextDestTwo.y].collision do
                add1.cood = add2.coord + add2.add
            end

            add2.coord = add2.coord + add2.add

            local costOne=#(nextDestOne-self.state)+#(nextDestOne-self.currentRoom.enemies[1]["pos"])
            local costTwo=#(nextDestTwo-self.state)+#(nextDestTwo-self.currentRoom.enemies[1]["pos"])

            if costOne <= costTwo then
                path[#path+1] = nextDestOne
            else
                path[#path+1] = nextDestTwo
            end
        end

    until found

    return path

end
