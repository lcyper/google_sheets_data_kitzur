import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sheets_data_kitzur/cubit/content_cubit.dart';
import 'package:google_sheets_data_kitzur/widgets/select_date.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SelectDate(),
            BlocBuilder<ContentCubit, ContentState>(
              bloc: context.read<ContentCubit>()..getData(DateTime.now()),
              builder: (context, state) {
                if (state is ContentError) {
                  return Text(
                    state.message,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Theme.of(context).errorColor,
                        ),
                  );
                } else if (state is ContentData) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'El estudio de hoy es: ${state.message}',
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: Theme.of(context).hintColor,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  // (state is ContentLoading)
                  return const CircularProgressIndicator.adaptive();
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Column(
                children: [
                  Text(
                    'Dedicado en memoria de anonimo',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    'Desarrollado por lcyper',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
