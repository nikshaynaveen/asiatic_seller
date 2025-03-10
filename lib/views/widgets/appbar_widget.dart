import 'package:asiatic_seller/const/const.dart';
import 'package:asiatic_seller/views/widgets/text_style.dart';
import 'package:intl/intl.dart' as intl;

AppBar appbarWidget(title) {
  return AppBar(
    backgroundColor: white,
    automaticallyImplyLeading: false,
    title: boldText(text: title, color: fontGrey, size: 16.0),
    actions: [
      Center(
        child: normalText(
            text: intl.DateFormat("EEE, MMM d, ''yy").format(DateTime.now()),
            color: purpleColor),
      ),
      10.widthBox
    ],
  );
}
