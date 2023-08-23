import 'package:datacoup/export.dart';

class Answer extends StatelessWidget {
  final int index;
  final String answerText;
  final bool isSelected;
  final void Function() answerTap;
  const Answer(
      {super.key,
      required this.answerText,
      required this.isSelected,
      required this.answerTap,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      width: 360.w,
      decoration: BoxDecoration(
        color: isSelected ? deepOrangeColor : Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: InkWell(
        onTap: answerTap,
        child: Row(
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.blueGrey.shade100, shape: BoxShape.circle),
                child: Text(
                  String.fromCharCode(index + 65),
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.w500),
                )),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                answerText,
                softWrap: true,
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: AssetConst.QUICKSAND_FONT,
                    color: isSelected ? Colors.white : Colors.grey.shade900),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
