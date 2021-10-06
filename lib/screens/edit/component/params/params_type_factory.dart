import 'package:baddog_flutter/screens/edit/component/params/templates/news_card_list_edit.dart';
import 'package:flutter/material.dart';

class ComponentTypeFactory {
  static Widget getTemplate({required typeId, required data}) {
    //default return
    if (typeId == 'NewsArticleCardList')
      return NewsCardListEditTemplate(data: data);

    return Text('Unfound Parameters template');
  }
}
