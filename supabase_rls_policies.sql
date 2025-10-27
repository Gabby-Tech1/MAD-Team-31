-- Supabase RLS Policies for ParkRight App
-- Run this in your Supabase SQL Editor

-- Enable RLS on all tables
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE vehicles ENABLE ROW LEVEL SECURITY;
ALTER TABLE parking_spots ENABLE ROW LEVEL SECURITY;
ALTER TABLE bookings ENABLE ROW LEVEL SECURITY;

-- Profiles table policies
CREATE POLICY "Users can view their own profile" ON profiles
FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update their own profile" ON profiles
FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "Users can insert their own profile" ON profiles
FOR INSERT WITH CHECK (auth.uid() = id);

-- Vehicles table policies
CREATE POLICY "Users can view their own vehicles" ON vehicles
FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own vehicles" ON vehicles
FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own vehicles" ON vehicles
FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own vehicles" ON vehicles
FOR DELETE USING (auth.uid() = user_id);

-- Parking spots table policies (assuming anyone can view, but only admins can modify)
CREATE POLICY "Anyone can view parking spots" ON parking_spots
FOR SELECT USING (true);

-- Bookings table policies
CREATE POLICY "Users can insert their own bookings" ON bookings
FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can view their own bookings" ON bookings
FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can update their own bookings" ON bookings
FOR UPDATE USING (auth.uid() = user_id);