package com.quizalyx.quizalyx

import androidx.test.ext.junit.rules.ActivityScenarioRule
import androidx.test.ext.junit.runners.AndroidJUnit4
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import androidx.test.espresso.flutter.EspressoFlutter.onFlutterWidget
import androidx.test.espresso.flutter.action.FlutterActions.click
import androidx.test.espresso.flutter.matcher.FlutterMatchers.withValueKey
import kotlin.concurrent.thread

@RunWith(AndroidJUnit4::class)
class HomeScreenTest {

    @get:Rule
    val activityRule = ActivityScenarioRule(MainActivity::class.java)

    // Start Button Test
    @Test
    fun appLaunchesAndStartButtonIsVisible() {
        // Forcing a wait until the app finishes its await operations!
        Thread.sleep(15000)

        // Directly click the Start button
        onFlutterWidget(withValueKey("start_quiz_button")).perform(click())

        // Wait 5 seconds to truly see the transition on the screen
        Thread.sleep(5000)
    }

    // Store Button Test
    @Test
    fun storeButtonWorks() {
        // Wait 15 seconds for the application to open
        Thread.sleep(15000);

        // Click the store button
        onFlutterWidget(withValueKey("nav_store_button")).perform(click())

        // Wait 5 seconds to truly see the transition on the screen
        Thread.sleep(5000)
    }

    // Settings Button Test
    @Test
    fun settingsButtonWorks() {
        // Wait 15 seconds for the application to open
        Thread.sleep(15000)

        // Click the settings button
        onFlutterWidget(withValueKey("nav_settings_button")).perform(click())

        // Wait 5 seconds to truly see the transition on the screen
        Thread.sleep(5000)
    }

    // Sound Button Test
    @Test
    fun soundButtonWorks() {
        // Wait 15 seconds for the application to open
        Thread.sleep(15000)

        // Click the sound on/off button
        onFlutterWidget(withValueKey("nav_sound_button")).perform(click())

        // Wait 5 seconds to truly see the transition on the screen
        Thread.sleep(5000)
    }

    // Missions Button Test
    @Test
    fun missionsButtonWorks() {
        // Wait 15 seconds for the application to open
        Thread.sleep(15000)

        // Click the missions button
        onFlutterWidget(withValueKey("nav_missions_button")).perform(click())

        // Wait 5 seconds to truly see the transition on the screen
        Thread.sleep(5000)
    }

    // Leaderboard Button Test
    @Test
    fun leaderboardButtonWorks() {
        // Wait 15 seconds for the application to open
        Thread.sleep(15000)

        // Click the leaderboard button
        onFlutterWidget(withValueKey("nav_leaderboard_button")).perform(click())

        // Wait 5 seconds to truly see the transition on the screen
        Thread.sleep(5000)
    }

    @Test
    fun startClassicQuizFlow() {
        // 1. Wait for the application to fully open
        Thread.sleep(15000)

        // 2. Click the START QUIZ button on the home screen
        onFlutterWidget(withValueKey("start_quiz_button")).perform(click())

        // 3. Wait for the mode selection (Dialog) screen to slide down and open
        Thread.sleep(5000)

        // 4. Click the CLASSIC mode in the opened menu
        onFlutterWidget(withValueKey("mode_classic_button")).perform(click())

        // 5. Wait for the topic selection screen to load and appear
        Thread.sleep(5000)

        // 6. Click the MATH category
        onFlutterWidget(withValueKey("topic_Math_button")).perform(click())

        // 7. Wait for the difficulty selection menu to open from the bottom
        Thread.sleep(5000)

        // 8. Click the BEGINNER (Easy) difficulty level
        onFlutterWidget(withValueKey("difficulty_Easy_button")).perform(click())

        // 9. Wait to observe the questions (QuestionScreen) loading and the actual quiz starting
        Thread.sleep(5000)

        // 10. Click the preparation button (Start Quiz) in the center of the screen
        onFlutterWidget(withValueKey("start_game_button")).perform(click())

        // 11. Wait for the question and options to slide onto the screen with animation
        Thread.sleep(5000)

        // 12. CLICK the first option (Option A / Index 0)!
        onFlutterWidget(withValueKey("option_0_button")).perform(click())

        // 12. Wait to observe the result (+10 points or cross effect)
        Thread.sleep(5000)

    }
}