SELECT * FROM rydfly.clean_data;

# 1. Retrieve all successful bookings
Create View Successful_Bookings As
SELECT * 
FROM clean_data
WHERE Booking_Status = 'Success';


# 2. Find average ride distance for each vehicle type
Create view average_ride_distance AS
SELECT Vehicle_Type, AVG(Ride_Distance) AS Avg_Ride_Distance
FROM clean_data
WHERE Booking_Status = 'Success'
GROUP BY Vehicle_Type;


# 3. Get total number of cancelled rides by customers
Create View cancelled_rides_by_customers As
SELECT COUNT(*) FROM clean_data
WHERE Booking_Status = 'Canceled by Customer';



# 4. Top 5 customers who booked the highest number of rides
Create view Top_5_customers As
SELECT Customer_ID, COUNT(*) AS Total_Rides
FROM clean_data
GROUP BY Customer_ID
ORDER BY Total_Rides DESC
LIMIT 5;


# 5. Cancelled rides by drivers due to personal & car-related issues
Create View Cancelled_rides_by_drivers As
SELECT COUNT(*) FROM clean_data
WHERE Canceled_Rides_by_Driver = 'Personal & Car related issue';
  

# 6. Max and min driver ratings for Auto bookings
Create View MAX_MIN_Ratings_for_Auto As
SELECT MAX(Driver_Ratings) AS Max_Rating, MIN(Driver_Ratings) AS Min_Rating
FROM clean_data
WHERE Vehicle_Type = 'Auto' AND Booking_Status = 'Success';
  
  
# 7. All rides where payment was made using Debit card
Create View All_rides_payment_mode_debit_card As
SELECT * FROM clean_data
WHERE Payment_Method = 'Debit Card' AND Booking_Status = 'Success';


# 8. Average customer rating per vehicle type
Create View customer_rating_with_vehicle_type AS
SELECT Vehicle_Type, AVG(Customer_Rating) AS Avg_Customer_Rating
FROM clean_data
WHERE Booking_Status = 'Success'
GROUP BY Vehicle_Type;


# 9. Total booking value of successful rides
Create view Total_successful_rides_value As
SELECT SUM(Booking_Value) AS Total_Revenue
FROM clean_data
WHERE Booking_Status = 'Success';
  
  
# 10. All incomplete rides with reason
Create view incomplete_rides_with_reason As
SELECT Booking_ID, Incomplete_Rides_Reason  FROM clean_data
WHERE Incomplete_Rides = 'Yes'; 


# 11. Find the most common reason customers cancel rides
Create view  most_common_reason_customers_cancel_rides AS
SELECT Canceled_Rides_by_Customer AS reason, COUNT(*) AS cancellation_count
FROM clean_data
WHERE Canceled_Rides_by_Customer != 'N/A'
GROUP BY Canceled_Rides_by_Customer
ORDER BY cancellation_count DESC
LIMIT 3;


# 12. Average VTAT and CTAT per vehicle type
Create view  Average_VTAT_and_CTAT AS
SELECT Vehicle_Type,
    ROUND(AVG(V_TAT), 2) AS Avg_Vehicle_TAT,
    ROUND(AVG(C_TAT), 2) AS Avg_Customer_TAT
FROM clean_data
WHERE Booking_Status = 'Success'
    AND V_TAT IS NOT NULL
    AND C_TAT IS NOT NULL
GROUP BY  Vehicle_Type;


 # 13. Success rate per day
Create view Success_rate_per_day AS
SELECT 
    Date,
    ROUND((SUM(CASE WHEN Booking_Status = 'Success' THEN 1 ELSE 0 END) / COUNT(*)) * 100,2) AS Success_Rate_Percentage
FROM clean_data
GROUP BY 
    Date
ORDER BY 
    Date;

    
# 14. Which vehicle type earns the most revenue?
Create view Total_revenue_with_vehicle_type AS 
select Vehicle_Type , SUM(Booking_Value) AS Total_revenue
From clean_data
where Booking_Status = 'Success'
Group by Vehicle_Type
Order by Total_revenue DESC;






