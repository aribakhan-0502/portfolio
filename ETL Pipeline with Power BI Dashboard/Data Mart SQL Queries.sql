GRANT ALL PRIVILEGES ON DATABASE "Public Transport (Karachi)" TO aribaandsumbal;
GRANT ALL PRIVILEGES ON SCHEMA public TO aribaandsumbal;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO aribaandsumbal;

--- Q1. Which stations experienced the highest passenger counts in the first quarter of 2024?
SELECT dr."RouteOrigin", SUM(dt."TotalTickets") AS PassengerCount
FROM "FactTripPerformance" ft
JOIN "DimRoutes" dr ON ft."RouteID" = dr."RouteID"
JOIN "DimDate" dd ON ft."DateID" = dd."DateID"
JOIN "DimTickets" dt ON ft."TicketID" = dt."TicketID"
WHERE dd."Year" = 2024 AND dd."Quarter" = 1
GROUP BY dr."RouteOrigin"
ORDER BY PassengerCount DESC;

--- Which types of incidents were most frequent throughout 2023?
SELECT di."IncType", COUNT(*) AS IncidentCount
FROM "FactTripPerformance" ft
JOIN "DimIncidents" di ON ft."IncidentID" = di."IncidentID"
JOIN "DimDate" dd ON ft."DateID" = dd."DateID"
WHERE dd."Year" = 2023
GROUP BY di."IncType"
ORDER BY IncidentCount DESC;

--- Q3. What are the month-to-month trends in passenger satisfaction scores for the last quarter of 2023?
SELECT dd."Month", SUM(ft."ComplaintCount") AS ComplaintCount
FROM "FactTripPerformance" ft
JOIN "DimDate" dd ON ft."DateID" = dd."DateID"
WHERE dd."Year" = 2023 AND dd."Quarter" = 4
GROUP BY dd."Month"
ORDER BY dd."Month";

--- Q4. Which routes had the highest on-time performance rates during the weekdays for the past 6 months?
SELECT dr."RouteName", 
       COUNT(*) FILTER (WHERE ft."Delay_Departure" = 0 AND ft."Delay_Arrival" = 0) AS OnTimeCount,
       COUNT(*) AS TotalWeekdayTrips,
       (COUNT(*) FILTER (WHERE ft."Delay_Departure" = 0 AND ft."Delay_Arrival" = 0) * 100.0 / COUNT(*)) AS OnTimeRate
FROM "FactTripPerformance" ft
JOIN "DimRoutes" dr ON ft."RouteID" = dr."RouteID"
JOIN "DimDate" dd ON ft."DateID" = dd."DateID"
WHERE dd."DateID" >= current_date - interval '6 months'
  AND dd."DayOfWeek" IN (1, 2, 3, 4, 5)
GROUP BY dr."RouteName"
ORDER BY OnTimeRate DESC;

--- Q5. Which days had a higher tendency to generate higher revenue in the 1st quarter of 2024?
SELECT dd."DayOfWeek", SUM(ft."TotalFare") AS TotalRevenue
FROM "FactTripPerformance" ft
JOIN "DimDate" dd ON ft."DateID" = dd."DateID"
WHERE dd."Year" = 2024 AND dd."Quarter" = 1
GROUP BY dd."DayOfWeek"
ORDER BY TotalRevenue DESC;

--- Q6. Which payment method seemed to be more famous among customers in 2023?
SELECT 'Cash' AS PaymentMethod, SUM("CashCount") AS TotalCount
FROM "DimTickets"
JOIN "FactTripPerformance" ON "DimTickets"."TicketID" = "FactTripPerformance"."TicketID"
JOIN "DimDate" ON "FactTripPerformance"."DateID" = "DimDate"."DateID"
WHERE "DimDate"."Year" = 2023

UNION ALL

SELECT 'Credit Card' AS PaymentMethod, SUM("CreditCount") AS TotalCount
FROM "DimTickets"
JOIN "FactTripPerformance" ON "DimTickets"."TicketID" = "FactTripPerformance"."TicketID"
JOIN "DimDate" ON "FactTripPerformance"."DateID" = "DimDate"."DateID"
WHERE "DimDate"."Year" = 2023

UNION ALL

SELECT 'Debit Card' AS PaymentMethod, SUM("DebitCount") AS TotalCount
FROM "DimTickets"
JOIN "FactTripPerformance" ON "DimTickets"."TicketID" = "FactTripPerformance"."TicketID"
JOIN "DimDate" ON "FactTripPerformance"."DateID" = "DimDate"."DateID"
WHERE "DimDate"."Year" = 2023

UNION ALL

SELECT 'Digital Wallet' AS PaymentMethod, SUM("WalletCount") AS TotalCount
FROM "DimTickets"
JOIN "FactTripPerformance" ON "DimTickets"."TicketID" = "FactTripPerformance"."TicketID"
JOIN "DimDate" ON "FactTripPerformance"."DateID" = "DimDate"."DateID"
WHERE "DimDate"."Year" = 2023;

--- Q7. Are there notable differences in the number of delays between weekdays and weekends?
SELECT
    CASE
        WHEN EXTRACT(DOW FROM dd."DateID") < 5 THEN 'Weekday'
        ELSE 'Weekend'
    END AS DayType,
    AVG(ft."Delay_Departure") AS AvgDepartureDelay,
    AVG(ft."Delay_Arrival") AS AvgArrivalDelay
FROM "FactTripPerformance" ft
JOIN "DimDate" dd ON ft."DateID" = dd."DateID"
GROUP BY DayType;


