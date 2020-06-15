SELECT 
    o.RoomCode, o.RoomName, o.Beds, o.bedType, o.maxOccupancy, o.basePrice, o.decor, o.NextAvailable, o.NextRes
FROM


(
SELECT RoomCode, RoomName, Beds, bedType, maxOccupancy, basePrice, decor, IF(RoomName IN

(
SELECT
    RoomName
FROM 
    lab7_reservations JOIN lab7_rooms ON lab7_reservations.room = lab7_rooms.RoomCode
WHERE
    Checkout >= CURDATE()
    AND
    Checkin >= CURDATE()
GROUP BY
    RoomName, RoomCode
)

, 'not today', 'Today') AS NextAvailable

,IF(RoomName IN
(
SELECT
    RoomName
FROM 
    lab7_reservations JOIN lab7_rooms ON lab7_reservations.room = lab7_rooms.RoomCode
WHERE
    Checkin >= CURDATE()
GROUP BY
    RoomName, RoomCode
)

, 'later date', 'None') AS NextRes

 
FROM
    lab7_reservations JOIN lab7_rooms ON lab7_reservations.room = lab7_rooms.RoomCode
GROUP BY
    RoomName, RoomCode
    
) o