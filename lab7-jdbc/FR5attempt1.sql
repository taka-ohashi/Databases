SELECT
    t.RoomName, t.Month, t.totalRevenue, SUM(totalRevenue) as yearlyTotal
FROM

(
SELECT 
    RoomName, MONTHNAME(Checkin) as Month, COUNT(Room) as Reservations, SUM(DATEDIFF(Checkout, Checkin) * Rate) AS totalRevenue
FROM
    lab7_reservations JOIN lab7_rooms ON lab7_reservations.Room = lab7_rooms.RoomCode
GROUP BY
    RoomName, MONTHNAME(Checkin)
) t
GROUP BY
    t.RoomName, t.Month