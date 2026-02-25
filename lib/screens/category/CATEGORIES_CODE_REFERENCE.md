# مرجع كود الـ Categories

## 1. الموديل (البيانات)
- **`lib/model/category_model.dart`**
  - `CategoryData`: id, name, categoryImage, color, description, isFeatured, status, services
  - `CategoryResponse`: categoryList, pagination
  - من الـ API: `category_image`, `name`, `color`, `id`, إلخ

## 2. الـ API
- **`lib/network/rest_apis.dart`**
  - `getCategoryListWithPagination()` – قائمة تصنيفات مع pagination
  - الـ endpoint: `category-list?page=&per_page=`
- بيانات الـ Home من **dashboard-detail** فيها `category` (قائمة تصنيفات)

## 3. كومبوننتات العرض
- **`lib/screens/dashboard/component/category_component.dart`**
  - القسم الكامل: عنوان "Categories" + View All + شبكة تصنيفات (AnimatedWrap)
  - يستقبل: `categoryList`, `isNewDashboard`
  - عند الضغط على تصنيف → يفتح ViewAllServiceScreen

- **`lib/screens/dashboard/component/category_widget.dart`**
  - عنصر واحد: صورة دائرية + اسم
  - يدعم SVG وصورة عادية، ويتغير الشكل حسب نوع الداشبورد (1,2,3,4)

## 4. الشاشات
- **`lib/screens/category/category_screen.dart`**
  - شاشة "كل التصنيفات" (التاب اللي في الـ Bottom Nav)
  - تعرض كل التصنيفات مع pagination

## 5. أماكن استخدام الـ Categories
- **Home (الداشبورد):** داخل `dashboard_fragment.dart` و `dashboard_fragment_1/2/3/4.dart`
  - `CategoryComponent(categoryList: snap.category.validate())`
- **تاب التصنيفات:** `dashboard_screen.dart` → `CategoryScreen()` عند index 2
- **تاب الحجوزات (مكان جديد):** قسم تصنيفات في أعلى الشاشة

## 6. استخدام سريع في أي شاشة
```dart
// استيراد
import 'package:booking_system_flutter/screens/dashboard/component/category_component.dart';
import 'package:booking_system_flutter/model/category_model.dart';

// تحتاج قائمة CategoryData من API أو cachedCategoryList
CategoryComponent(
  categoryList: yourCategoryList, // List<CategoryData>?
  isNewDashboard: false,
)
```
