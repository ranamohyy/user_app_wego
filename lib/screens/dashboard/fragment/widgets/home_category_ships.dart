import '../../../../model/category_model.dart';
import 'imports.dart';

class HomeCategoryChips extends StatelessWidget {
  final List<CategoryData> categories;
  final int? selectedIndex;
  final ValueChanged<int>? onSelected;

  const HomeCategoryChips({
    Key? key,
    required this.categories,
    this.selectedIndex,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: rh(context, 85),
      color: appStore.isDarkMode ? Colors.white : Colors.transparent,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: rs(context, 0)),
        children: [
          HomeCategoryChip(
            label: 'For you',
            withIcon: true,
            selected: 0 == (selectedIndex ?? 0),
            onTap: () => onSelected?.call(0),
          ),
          SizedBox(width: rs(context, 12)),
          ...List.generate(categories.length, (i) {
            final cat = categories[i];
            final selected = selectedIndex == i + 1;

            return Padding(
              padding: EdgeInsets.only(right: rs(context, 12)),
              child: HomeCategoryChip(
                label: cat.name.validate(),
                withIcon: false,
                selected: selected,
                onTap: () => onSelected?.call(i + 1),
              ),
            );
          }),
        ],
      ),
    );
  }
}
class HomeCategoryChip extends StatelessWidget {
  final String label;
  final bool withIcon;
  final bool selected;
  final VoidCallback onTap;

  const HomeCategoryChip({
    Key? key,
    required this.label,
    required this.withIcon,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: rs(context, 90),
        padding: EdgeInsets.symmetric(vertical: rh(context, 12)),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(rs(context, 14)),
            topRight: Radius.circular(rs(context, 14)),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (withIcon)
              Icon(
                Icons.auto_awesome,
                size: rs(context, 22),
                color: selected ? primaryColor : Colors.white,
              ),
            if (withIcon) SizedBox(height: rh(context, 6)),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: selected ? primaryColor : Colors.white,
                fontSize: rs(context, 13).roundToDouble(),
                fontWeight:
                selected ? FontWeight.w700 : FontWeight.w500,
                fontFamily: kHomeFontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }
}