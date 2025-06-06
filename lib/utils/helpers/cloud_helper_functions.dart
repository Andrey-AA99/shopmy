import 'package:flutter/material.dart';

class TCloudHelperFunction {
  static Widget? checkSingleRecordState<T>(AsyncSnapshot<T> snapshot){
    if(snapshot.connectionState == ConnectionState.waiting){
      return const Center(child: CircularProgressIndicator());
    }

    if(!snapshot.hasData || snapshot.data == null){
      return const Center(child: Text('Данные не найдены'));
    }

    if(snapshot.hasError){
      return const Center(child: Text('Что-то пsошло не так'));
    }

    return null;
  }

  static Widget? checkMultiRecordState<T>({required AsyncSnapshot<List<T>> snapshot,Widget? loader, Widget? error, Widget? nothingFound}){
    if(snapshot.connectionState == ConnectionState.waiting){
      if(loader != null) return loader;
      return const Center(child: CircularProgressIndicator());
    }

    if(!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty){
      if(nothingFound != null) return nothingFound;
      return const Center(child: Text('Данные не найдены'),);
    }

    if(snapshot.hasError){
      if(error != null) return error;
      return const Center(child: Text('Что-то пошло не так'));
    }

    return null;
  }


}