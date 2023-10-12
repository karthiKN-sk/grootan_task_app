import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grootan_task_app/firebase_options.dart';
import 'package:grootan_task_app/presentation/controllers/auth/auth_controller.dart';
import 'package:grootan_task_app/presentation/views/login_page.dart';
import 'package:mockito/mockito.dart';

class MockUserRepository extends Mock implements AuthController {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseUser extends Mock implements User {}

class MockBuildContext extends Mock implements BuildContext {}

void main() async {
  ///
  late MockUserRepository repo;
  late MockBuildContext context;

  ///
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    repo = MockUserRepository();
    context = MockBuildContext();
  });

  ///
  Widget makeTestable(Widget child) {
    return MaterialApp(
      home: child,
    );
  }

  ///Login
  var phoneField = find.text("Enter Phone number");
  var loginButton = find.text("Login");
  var login = find.text("Login".toUpperCase());

  ///OTP
  var otpField = find.text("Enter OTP");
  var verifyButton = find.text("Verify Otp");
  var otp = find.text("otp".toUpperCase());

  ///Login Page Widgets Testing
  group("Login Page Widgets Testing", () {
    ///
    testWidgets('Phone Field and Login button are found in Login Page',
        (WidgetTester tester) async {
      ///
      await tester.pumpWidget(makeTestable(const LoginPage()));

      ///
      expect(login, findsOneWidget);
      expect(phoneField, findsOneWidget);
      expect(loginButton, findsOneWidget);
    });
    testWidgets("validates empty Phone Number", (WidgetTester tester) async {
      ///
      await tester.pumpWidget(makeTestable(const LoginPage()));
      await tester.tap(loginButton);
      await tester.pump();

      ///
      expect(find.text("Please Enter Phone Number"), findsOneWidget);
    });

    testWidgets("calls Login method when Phone Number is entered",
        (WidgetTester tester) async {
      ///
      await tester.pumpWidget(makeTestable(const LoginPage()));

      ///
      await tester.enterText(phoneField, "+919659643583");
      await tester.tap(loginButton);
      await tester.pump();

      ///
      verify(repo.signInWithPhone(
        context,
        phoneNumber: "+919659643583",
        verifyId: (p0) {},
      )).called(1);
    });
  });

  ///OTP Page Widgets Testing
  group("OTP Page Widgets Testing", () {
    ///
    testWidgets('OTP Field and Verify button are found in OTP Page',
        (WidgetTester tester) async {
      ///
      await tester.pumpWidget(makeTestable(const LoginPage()));

      ///
      expect(otp, findsOneWidget);
      expect(otpField, findsOneWidget);
      expect(verifyButton, findsOneWidget);
    });
    testWidgets("validates empty Phone Number", (WidgetTester tester) async {
      ///
      await tester.pumpWidget(makeTestable(const LoginPage()));
      await tester.tap(verifyButton);
      await tester.pump();

      ///
      expect(find.text("Please Enter OTP Number"), findsOneWidget);
    });

    testWidgets("call verify method when Otp is entered",
        (WidgetTester tester) async {
      ///
      await tester.pumpWidget(makeTestable(const LoginPage()));

      ///
      await tester.enterText(otpField, "123456");
      await tester.tap(verifyButton);
      await tester.pump();

      ///
      verify(
        repo.verifyOTP(
          context: context,
          verificationId: "verificationId",
          userOtP: "123456",
          onSuccess: () {},
        ),
      ).called(1);
    });
  });
}
