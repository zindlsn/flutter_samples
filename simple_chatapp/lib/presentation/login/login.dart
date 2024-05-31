import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/application/login/bloc/login_bloc.dart';
import 'package:start/presentation/chatlist/chat_list.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phoneController = TextEditingController();
  final codeController = TextEditingController();
  final TextEditingController _smsCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is PhoneVerified) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Enter SMS Code'),
              content: Column(
                children: [
                  Text(state.result.phoneNumber!),
                  TextField(
                    controller: _smsCodeController,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: const Text('Verify'),
                  onPressed: () {
                    BlocProvider.of<LoginBloc>(context).add(ConfirmPhoneNumber(
                        authResult: state.result,
                        code: _smsCodeController.text));
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        }
      },
      builder: (context, state) {
        return BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChatList(),
                ),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: Center(
                child: Column(
                  children: [
                    Form(
                      child: TextFormField(
                        controller: phoneController,
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: phoneController.text.isNotEmpty
                          ? () {
                              BlocProvider.of<LoginBloc>(context).add(
                                  PhoneLogin(
                                      phoneNumber: phoneController.text));
                            }
                          : null,
                      child: const Text('Login By Phone'),
                    ),
                    TextFormField(
                      controller: codeController,
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
