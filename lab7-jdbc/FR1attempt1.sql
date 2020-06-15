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

, Checkout, 'Today') AS NextAvailable

,IF(RoomName IN
(
SELECT
    RoomName
FROM 
    lab7_reservations JOIN lab7_rooms ON lab7_reservations.room = lab7_rooms.RoomCode
WHERE
    Checkin >= CURDATE()
GROUP BY
    RoomName, RoomCode, Checkin
)

, Checkin, 'None') AS NextRes

 
FROM
    lab7_reservations JOIN lab7_rooms ON lab7_reservations.room = lab7_rooms.RoomCode
GROUP BY
    RoomName, RoomCode, Checkout, Checkin
    
) o


LEFT JOIN

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

, Checkout, 'Today') AS NextAvailable

,IF(RoomName IN
(
SELECT
    RoomName
FROM 
    lab7_reservations JOIN lab7_rooms ON lab7_reservations.room = lab7_rooms.RoomCode
WHERE
    Checkin >= CURDATE()
GROUP BY
    RoomName, RoomCode, Checkin
)

, Checkin, 'None') AS NextRes

 
FROM
    lab7_reservations JOIN lab7_rooms ON lab7_reservations.room = lab7_rooms.RoomCode
GROUP BY
    RoomName, RoomCode, Checkout, Checkin
    
) b


ON o.RoomCode = b.RoomCode AND o.NextAvailable < b.NextAvailable
WHERE b.NextAvailable is NULL 