# ParkRight Integration Test Script

## Overview
This script helps you test the Supabase and HERE Maps integration step by step.

## Prerequisites
- Flutter app is set up with all dependencies installed
- Supabase project is created and configured
- HERE Maps API key is obtained
- API keys are configured in `lib/utils/config.dart`

## Test Steps

### 1. Dependency Installation Test
```bash
flutter pub get
```
**Expected:** No errors, all packages download successfully

### 2. Build Test
```bash
flutter build apk --debug
```
**Expected:** Build completes without errors

### 3. Authentication Flow Test

#### Step 3.1: Start the App
```bash
flutter run
```

#### Step 3.2: Test Phone Authentication
1. Open the app
2. Navigate to Login screen
3. Select country code (+91 for India)
4. Enter a valid phone number (e.g., 9876543210)
5. Click "Send Code"

#### Step 3.3: Check Supabase Dashboard
1. Go to https://supabase.com/dashboard
2. Open your project
3. Go to Authentication → Logs
4. **Expected:** See a new OTP log entry

#### Step 3.4: Complete OTP Verification
1. Go back to the app
2. Enter the 6-digit OTP from Supabase logs
3. Click "Verify"
4. **Expected:** Navigate to Add Vehicle screen

#### Step 3.5: Add Vehicle
1. Fill in vehicle details:
   - License Plate: "ABC123"
   - Car Model: "Toyota Camry"
   - Vehicle Type: "Car"
2. Click "Add Vehicle"
3. **Expected:** Navigate to Verification screen

#### Step 3.6: Complete Phone Verification Again
1. Enter OTP again (check Supabase logs)
2. Click "Verify"
3. **Expected:** Navigate to Home screen

### 4. Database Verification

#### Step 4.1: Check User Creation
1. Go to Supabase Dashboard → Table Editor
2. Check `profiles` table
3. **Expected:** See new user record with phone number

#### Step 4.2: Check Vehicle Creation
1. Check `vehicles` table
2. **Expected:** See new vehicle record linked to user

### 5. HERE Maps Test

#### Step 5.1: Test Map Display
1. Go to Map screen in the app
2. **Expected:** Map loads with HERE Maps tiles

#### Step 5.2: Test Location Services
1. Grant location permissions when prompted
2. **Expected:** Map shows current location

### 6. API Integration Test

#### Step 6.1: Test Parking Spots Loading
1. Go to Home screen
2. **Expected:** Parking spots load from database (may be empty initially)

#### Step 6.2: Test Vehicle Loading
1. Go to Profile screen
2. **Expected:** User's vehicles display correctly

## Troubleshooting

### Issue: Build fails with dependency errors
**Solution:**
```bash
flutter clean
flutter pub cache repair
flutter pub get
```

### Issue: Supabase connection fails
**Solution:**
- Check API keys in `config.dart`
- Verify Supabase project is active
- Check internet connection

### Issue: Authentication fails
**Solution:**
- Verify phone authentication is enabled in Supabase
- Check phone number format (+country code)
- Ensure SMS provider is configured (for production)

### Issue: HERE Maps not loading
**Solution:**
- Verify API key is correct
- Check HERE project has correct permissions
- Ensure API key is not expired

### Issue: Database tables not created
**Solution:**
- Run the SQL commands in Supabase SQL Editor
- Check table permissions and RLS policies

## Performance Checks

### Memory Usage
```bash
flutter run --profile
```
**Expected:** App runs smoothly without excessive memory usage

### Network Calls
- Monitor network tab in browser dev tools (web version)
- **Expected:** Efficient API calls, no excessive requests

## Success Criteria

✅ **All tests pass without errors**
✅ **Authentication flow works end-to-end**
✅ **Database operations successful**
✅ **Map displays correctly**
✅ **No crashes or freezes**
✅ **UI responds smoothly**

## Next Steps After Testing

1. **Add sample data** to test with real parking spots
2. **Implement image upload** functionality
3. **Add booking system** integration
4. **Implement push notifications**
5. **Add payment processing**
6. **Optimize for production** deployment

## Support

If tests fail:
1. Check the troubleshooting section above
2. Review error messages in console
3. Check Supabase/HERE dashboards for issues
4. Verify all configuration steps were completed
5. Check Flutter version compatibility

## Test Results Template

```
Test Date: __________
Tester: __________

Test Results:
✅ Dependency Installation: PASS/FAIL
✅ Build Test: PASS/FAIL
✅ Authentication Flow: PASS/FAIL
✅ Database Operations: PASS/FAIL
✅ HERE Maps Integration: PASS/FAIL
✅ API Integration: PASS/FAIL

Issues Found:
1. __________________________
2. __________________________
3. __________________________

Notes:
__________________________
__________________________
```

This comprehensive test ensures your ParkRight app integration is working correctly before moving to production.