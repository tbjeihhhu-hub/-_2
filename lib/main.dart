import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const LamhaApp());
}

// ==================== التطبيق الرئيسي ====================
class LamhaApp extends StatelessWidget {
  const LamhaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'لمحة - Lamha',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFFF6B00),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        fontFamily: 'Cairo',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF6B00),
          primary: const Color(0xFFFF6B00),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFF6B00),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

// ==================== الموديلات ====================
enum ServiceType { restaurant, pharmacy, grocery, mechanic }

enum OrderStatus { pending, accepted, preparing, onTheWay, delivered, cancelled }

class UserModel {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String address;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
  });
}

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String image;
  final String storeId;
  final String storeName;
  final ServiceType type;
  final double rating;
  final bool inStock;
  final String? category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.storeId,
    required this.storeName,
    required this.type,
    this.rating = 4.5,
    this.inStock = true,
    this.category,
  });
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get totalPrice => product.price * quantity;
}

class OrderModel {
  final String id;
  final String userId;
  final List<CartItem> items;
  final double total;
  final double deliveryFee;
  final OrderStatus status;
  final String serviceType;
  final String address;
  final String phone;
  final DateTime createdAt;
  final String? driverName;
  final String? driverPhone;

  OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.total,
    required this.deliveryFee,
    required this.status,
    required this.serviceType,
    required this.address,
    required this.phone,
    required this.createdAt,
    this.driverName,
    this.driverPhone,
  });
}

// ==================== البيانات الوهمية ====================
class MockData {
  static UserModel? currentUser;

  static List<Product> get restaurants => [
        Product(
          id: 'r1',
          name: 'برجر لحم مشوي',
          description: 'برجر لحم طازج مع جبنة وخضار',
          price: 8000,
          image: '🍔',
          storeId: 's1',
          storeName: 'مطعم البرجر الذهبي',
          type: ServiceType.restaurant,
          category: 'برجر',
        ),
        Product(
          id: 'r2',
          name: 'شاورما دجاج',
          description: 'شاورما دجاج مع ثومية وبطاطا',
          price: 5000,
          image: '🌯',
          storeId: 's1',
          storeName: 'مطعم البرجر الذهبي',
          type: ServiceType.restaurant,
          category: 'شاورما',
        ),
        Product(
          id: 'r3',
          name: 'بيتزا مارغريتا',
          description: 'بيتزا إيطالية أصلية',
          price: 12000,
          image: '🍕',
          storeId: 's2',
          storeName: 'بيتزا إيطاليا',
          type: ServiceType.restaurant,
          category: 'بيتزا',
        ),
        Product(
          id: 'r4',
          name: 'كبسة دجاج',
          description: 'كبسة دجاج عراقية تقليدية',
          price: 7000,
          image: '🍛',
          storeId: 's3',
          storeName: 'مطعم بغداد',
          type: ServiceType.restaurant,
          category: 'أرز',
        ),
        Product(
          id: 'r5',
          name: 'كباب مشكل',
          description: 'كباب لحم مع خبز تنور',
          price: 10000,
          image: '🍢',
          storeId: 's3',
          storeName: 'مطعم بغداد',
          type: ServiceType.restaurant,
          category: 'مشاوي',
        ),
      ];

  static List<Product> get pharmacies => [
        Product(
          id: 'p1',
          name: 'باراسيتامول 500mg',
          description: 'مسكن وخافض للحرارة',
          price: 3000,
          image: '💊',
          storeId: 'ph1',
          storeName: 'صيدلية الشفاء',
          type: ServiceType.pharmacy,
          category: 'مسكنات',
        ),
        Product(
          id: 'p2',
          name: 'فيتامين C',
          description: 'مكمل غذائي 1000mg',
          price: 15000,
          image: '🧪',
          storeId: 'ph1',
          storeName: 'صيدلية الشفاء',
          type: ServiceType.pharmacy,
          category: 'فيتامينات',
        ),
        Product(
          id: 'p3',
          name: 'كحول طبي',
          description: 'معقم 500ml',
          price: 4000,
          image: '🧴',
          storeId: 'ph2',
          storeName: 'صيدلية الحياة',
          type: ServiceType.pharmacy,
          category: 'معقمات',
        ),
        Product(
          id: 'p4',
          name: 'كمامات طبية',
          description: 'علبة 50 كمامة',
          price: 8000,
          image: '😷',
          storeId: 'ph2',
          storeName: 'صيدلية الحياة',
          type: ServiceType.pharmacy,
          category: 'وقاية',
        ),
      ];

  static List<Product> get groceries => [
        Product(
          id: 'g1',
          name: 'حليب طازج',
          description: 'حليب بقري 1 لتر',
          price: 2500,
          image: '🥛',
          storeId: 'gr1',
          storeName: 'سوبرماركت الأمل',
          type: ServiceType.grocery,
          category: 'ألبان',
        ),
        Product(
          id: 'g2',
          name: 'خبز صمون',
          description: 'خبز طازج 10 حبات',
          price: 1500,
          image: '🍞',
          storeId: 'gr1',
          storeName: 'سوبرماركت الأمل',
          type: ServiceType.grocery,
          category: 'مخبوزات',
        ),
        Product(
          id: 'g3',
          name: 'بيض بلدي',
          description: 'علبة 30 بيضة',
          price: 6000,
          image: '🥚',
          storeId: 'gr2',
          storeName: 'سوبرماركت الخير',
          type: ServiceType.grocery,
          category: 'بيض',
        ),
        Product(
          id: 'g4',
          name: 'أرز بسمتي',
          description: 'أرز هندي 5 كغم',
          price: 12000,
          image: '🍚',
          storeId: 'gr2',
          storeName: 'سوبرماركت الخير',
          type: ServiceType.grocery,
          category: 'حبوب',
        ),
        Product(
          id: 'g5',
          name: 'زيت نباتي',
          description: 'زيت دوار الشمس 2 لتر',
          price: 8000,
          image: '🫒',
          storeId: 'gr1',
          storeName: 'سوبرماركت الأمل',
          type: ServiceType.grocery,
          category: 'زيوت',
        ),
      ];

  static List<Product> get mechanics => [
        Product(
          id: 'm1',
          name: 'تغيير زيت المحرك',
          description: 'زيت محرك + فلتر + عمل',
          price: 35000,
          image: '🛢️',
          storeId: 'me1',
          storeName: 'ورشة الصنايعية',
          type: ServiceType.mechanic,
          category: 'صيانة',
        ),
        Product(
          id: 'm2',
          name: 'تبديل بطارية',
          description: 'بطارية 60 أمبير + تركيب',
          price: 85000,
          image: '🔋',
          storeId: 'me1',
          storeName: 'ورشة الصنايعية',
          type: ServiceType.mechanic,
          category: 'كهرباء',
        ),
        Product(
          id: 'm3',
          name: 'إصلاح بنشر',
          description: 'تصليح أو تبديل إطار',
          price: 15000,
          image: '🛞',
          storeId: 'me2',
          storeName: 'بنشر السريع',
          type: ServiceType.mechanic,
          category: 'إطارات',
        ),
        Product(
          id: 'm4',
          name: 'غسيل سيارة كامل',
          description: 'غسيل خارجي وداخلي',
          price: 10000,
          image: '🚗',
          storeId: 'me2',
          storeName: 'بنشر السريع',
          type: ServiceType.mechanic,
          category: 'تنظيف',
        ),
        Product(
          id: 'm5',
          name: 'فحص كمبيوتر',
          description: 'فحص شامل للسيارة',
          price: 20000,
          image: '🔧',
          storeId: 'me1',
          storeName: 'ورشة الصنايعية',
          type: ServiceType.mechanic,
          category: 'فحص',
        ),
      ];

  static List<Product> getProductsByType(ServiceType type) {
    switch (type) {
      case ServiceType.restaurant:
        return restaurants;
      case ServiceType.pharmacy:
        return pharmacies;
      case ServiceType.grocery:
        return groceries;
      case ServiceType.mechanic:
        return mechanics;
    }
  }

  static List<OrderModel> orders = [];
}

// ==================== شاشة البداية ====================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFF6B00), Color(0xFFFF8C00)],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _animation,
            child: ScaleTransition(
              scale: _animation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '🚀',
                    style: TextStyle(fontSize: 100),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'لمحة',
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'كل احتياجاتك في مكان واحد',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 50),
                  const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== شاشة تسجيل الدخول ====================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    if (_phoneController.text.isEmpty || _passwordController.text.isEmpty) {
      _showSnackBar('الرجاء إدخال جميع البيانات');
      return;
    }

    MockData.currentUser = UserModel(
      id: '1',
      name: 'أحمد محمد',
      phone: _phoneController.text,
      email: 'ahmed@example.com',
      address: 'بغداد - الكرادة',
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFFF6B00),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFF6B00), Color(0xFFFF8C00)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text(
                  '🚀',
                  style: TextStyle(fontSize: 80),
                ),
                const SizedBox(height: 20),
                const Text(
                  'لمحة',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'توصيل سريع لكل احتياجاتك',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'رقم الهاتف',
                          prefixIcon: const Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'كلمة المرور',
                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'دخول',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'ليس لديك حساب؟ سجل الآن',
                          style: TextStyle(color: Color(0xFFFF6B00)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== شاشة التسجيل ====================
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();

  void _register() {
    if (_nameController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      _showSnackBar('الرجاء إدخال جميع البيانات المطلوبة');
      return;
    }

    MockData.currentUser = UserModel(
      id: '1',
      name: _nameController.text,
      phone: _phoneController.text,
      email: _emailController.text,
      address: _addressController.text,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFFF6B00),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إنشاء حساب جديد'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              'مرحباً بك في لمحة',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'أنشئ حسابك الآن واستمتع بخدماتنا',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'الاسم الكامل',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'رقم الهاتف',
                prefixIcon: const Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'البريد الإلكتروني (اختياري)',
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'كلمة المرور',
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'العنوان',
                prefixIcon: const Icon(Icons.location_on),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _register,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'إنشاء حساب',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'لديك حساب؟ سجل دخول',
                style: TextStyle(color: Color(0xFFFF6B00)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== الشاشة الرئيسية ====================
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const OrdersScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFFF6B00),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'طلباتي',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'حسابي',
          ),
        ],
      ),
    );
  }
}

// ==================== الشاشة الرئيسية ====================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لمحة'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('لا توجد إشعارات جديدة')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // بطاقة الترحيب
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF6B00), Color(0xFFFF8C00)],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF6B00).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'مرحباً ${MockData.currentUser?.name ?? 'ضيف'} 👋',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'ماذا تحتاج اليوم؟',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            // الخدمات
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                'خدماتنا',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildServiceCard(
                    context,
                    '🍔',
                    'مطاعم',
                    'اطلب وجبتك المفضلة',
                    ServiceType.restaurant,
                  ),
                  _buildServiceCard(
                    context,
                    '💊',
                    'صيدليات',
                    'أدوية ومستلزمات طبية',
                    ServiceType.pharmacy,
                  ),
                  _buildServiceCard(
                    context,
                    '🛒',
                    'سوبرماركت',
                    'كل احتياجات البيت',
                    ServiceType.grocery,
                  ),
                  _buildServiceCard(
                    context,
                    '🔧',
                    'تصليح سيارات',
                    'صيانة وتصليح سيارتك',
                    ServiceType.mechanic,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // عروض خاصة
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                'عروض خاصة',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 3,
                itemBuilder: (context, index) {
                  final offers = [
                    {'title': 'خصم 20%', 'subtitle': 'على جميع المطاعم', 'color': Colors.red},
                    {'title': 'توصيل مجاني', 'subtitle': 'للطلبات فوق 20,000 د.ع', 'color': Colors.green},
                    {'title': 'عرض الجمعة', 'subtitle': 'اشتري 2 واحصل على 1 مجاناً', 'color': Colors.blue},
                  ];
                  return Container(
                    width: 250,
                    margin: const EdgeInsets.only(left: 12),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          offers[index]['color'] as Color,
                          (offers[index]['color'] as Color).withOpacity(0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          offers[index]['title'] as String,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          offers[index]['subtitle'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context,
    String icon,
    String title,
    String subtitle,
    ServiceType type,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CategoryScreen(serviceType: type),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              icon,
              style: const TextStyle(fontSize: 50),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== شاشة الفئة ====================
class CategoryScreen extends StatelessWidget {
  final ServiceType serviceType;

  const CategoryScreen({super.key, required this.serviceType});

  String get _title {
    switch (serviceType) {
      case ServiceType.restaurant:
        return 'المطاعم';
      case ServiceType.pharmacy:
        return 'الصيدليات';
      case ServiceType.grocery:
        return 'السوبرماركت';
      case ServiceType.mechanic:
        return 'تصليح السيارات';
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = MockData.getProductsByType(serviceType);
    final stores = products.map((p) => p.storeName).toSet().toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Column(
        children: [
          // قائمة المتاجر
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: stores.length,
              itemBuilder: (context, index) {
                final storeProducts = products
                    .where((p) => p.storeName == stores[index])
                    .toList();
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => StoreScreen(
                          storeName: stores[index],
                          products: storeProducts,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 100,
                    margin: const EdgeInsets.only(left: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.store,
                          size: 40,
                          color: Color(0xFFFF6B00),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          stores[index],
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(),
          // قائمة المنتجات
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return _buildProductCard(context, products[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              product.image,
              style: const TextStyle(fontSize: 30),
            ),
          ),
        ),
        title: Text(
          product.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.storeName),
            const SizedBox(height: 4),
            Text(
              '${product.price.toStringAsFixed(0)} د.ع',
              style: const TextStyle(
                color: Color(0xFFFF6B00),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.add_shopping_cart),
          color: const Color(0xFFFF6B00),
          onPressed: () {
            CartProvider.instance.add(product);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تمت الإضافة إلى السلة'),
                duration: Duration(seconds: 1),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ==================== شاشة المتجر ====================
class StoreScreen extends StatelessWidget {
  final String storeName;
  final List<Product> products;

  const StoreScreen({
    super.key,
    required this.storeName,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(storeName),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    product.image,
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              ),
              title: Text(
                product.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(product.description),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${product.price.toStringAsFixed(0)} د.ع',
                    style: const TextStyle(
                      color: Color(0xFFFF6B00),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  IconButton(
                    icon: const Icon(Icons.add_shopping_cart),
                    color: const Color(0xFFFF6B00),
                    onPressed: () {
                      CartProvider.instance.add(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('تمت الإضافة إلى السلة'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CartScreen()),
          );
        },
        backgroundColor: const Color(0xFFFF6B00),
        icon: const Icon(Icons.shopping_cart),
        label: Text(
          'السلة (${CartProvider.instance.items.length})',
        ),
      ),
    );
  }
}

// ==================== شاشة السلة ====================
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _addressController = TextEditingController(
    text: MockData.currentUser?.address ?? '',
  );
  final _phoneController = TextEditingController(
    text: MockData.currentUser?.phone ?? '',
  );

  @override
  Widget build(BuildContext context) {
    final cart = CartProvider.instance;
    final subtotal = cart.totalPrice;
    final deliveryFee = 3000.0;
    final total = subtotal + deliveryFee;

    return Scaffold(
      appBar: AppBar(
        title: const Text('سلة المشتريات'),
      ),
      body: cart.items.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 100,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'السلة فارغة',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF3E0),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                item.product.image,
                                style: const TextStyle(fontSize: 30),
                              ),
                            ),
                          ),
                          title: Text(item.product.name),
                          subtitle: Text(
                            '${item.product.price.toStringAsFixed(0)} د.ع',
                            style: const TextStyle(
                              color: Color(0xFFFF6B00),
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () {
                                  setState(() {
                                    cart.updateQuantity(
                                      item.product.id,
                                      item.quantity - 1,
                                    );
                                  });
                                },
                              ),
                              Text(
                                '${item.quantity}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: () {
                                  setState(() {
                                    cart.updateQuantity(
                                      item.product.id,
                                      item.quantity + 1,
                                    );
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    cart.remove(item.product.id);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          labelText: 'عنوان التوصيل',
                          prefixIcon: const Icon(Icons.location_on),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'رقم الهاتف',
                          prefixIcon: const Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('المجموع الفرعي:'),
                          Text('${subtotal.toStringAsFixed(0)} د.ع'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('رسوم التوصيل:'),
                          Text('${deliveryFee.toStringAsFixed(0)} د.ع'),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'الإجمالي:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${total.toStringAsFixed(0)} د.ع',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFF6B00),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => _checkout(context, total, deliveryFee),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'تأكيد الطلب',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  void _checkout(BuildContext context, double total, double deliveryFee) {
    if (_addressController.text.isEmpty || _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء إدخال العنوان ورقم الهاتف')),
      );
      return;
    }

    final order = OrderModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: MockData.currentUser?.id ?? '',
      items: List.from(CartProvider.instance.items),
      total: total,
      deliveryFee: deliveryFee,
      status: OrderStatus.pending,
      serviceType: CartProvider.instance.items.first.product.type.name,
      address: _addressController.text,
      phone: _phoneController.text,
      createdAt: DateTime.now(),
    );

    MockData.orders.add(order);
    CartProvider.instance.clear();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تم الطلب بنجاح'),
        content: const Text('سيتم التواصل معك قريباً لتأكيد الطلب'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }
}

// ==================== شاشة الطلبات ====================
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('طلباتي'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              );
            },
          ),
        ],
      ),
      body: MockData.orders.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 100,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'لا توجد طلبات',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: MockData.orders.length,
              itemBuilder: (context, index) {
                final order = MockData.orders[index];
                return _buildOrderCard(context, order);
              },
            ),
    );
  }

  Widget _buildOrderCard(BuildContext context, OrderModel order) {
    final statusColor = _getStatusColor(order.status);
    final statusText = _getStatusText(order.status);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'طلب #${order.id.substring(0, 8)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'عدد المنتجات: ${order.items.length}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              'الإجمالي: ${order.total.toStringAsFixed(0)} د.ع',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF6B00),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'التاريخ: ${DateFormat('yyyy-MM-dd HH:mm').format(order.createdAt)}',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            if (order.driverName != null) ...[
              const SizedBox(height: 12),
              const Divider(),
              Row(
                children: [
                  const Icon(Icons.delivery_dining, color: Color(0xFFFF6B00)),
                  const SizedBox(width: 8),
                  Text(
                    'السائق: ${order.driverName}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.accepted:
        return Colors.blue;
      case OrderStatus.preparing:
        return Colors.purple;
      case OrderStatus.onTheWay:
        return Colors.cyan;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }

  String _getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'قيد الانتظار';
      case OrderStatus.accepted:
        return 'تم القبول';
      case OrderStatus.preparing:
        return 'جاري التحضير';
      case OrderStatus.onTheWay:
        return 'في الطريق';
      case OrderStatus.delivered:
        return 'تم التسليم';
      case OrderStatus.cancelled:
        return 'ملغي';
    }
  }
}

// ==================== شاشة الحساب ====================
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = MockData.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('حسابي'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // صورة المستخدم
            CircleAvatar(
              radius: 60,
              backgroundColor: const Color(0xFFFF6B00),
              child: const Icon(
                Icons.person,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              user?.name ?? 'ضيف',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              user?.phone ?? '',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            // قائمة الخيارات
            _buildMenuItem(
              context,
              Icons.person_outline,
              'تعديل الملف الشخصي',
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('قريباً...')),
                );
              },
            ),
            _buildMenuItem(
              context,
              Icons.location_on_outlined,
              'عناويني المحفوظة',
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('قريباً...')),
                );
              },
            ),
            _buildMenuItem(
              context,
              Icons.payment_outlined,
              'طرق الدفع',
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('قريباً...')),
                );
              },
            ),
            _buildMenuItem(
              context,
              Icons.help_outline,
              'المساعدة والدعم',
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('قريباً...')),
                );
              },
            ),
            _buildMenuItem(
              context,
              Icons.info_outline,
              'عن التطبيق',
              () {
                showAboutDialog(
                  context: context,
                  applicationName: 'لمحة',
                  applicationVersion: '1.0.0',
                  applicationIcon: const Text('🚀', style: TextStyle(fontSize: 40)),
                  children: [
                    const Text('تطبيق توصيل شامل لكل احتياجاتك'),
                    const SizedBox(height: 10),
                    const Text('مطاعم - صيدليات - سوبرماركت - تصليح سيارات'),
                  ],
                );
              },
            ),
            const Divider(),
            _buildMenuItem(
              context,
              Icons.logout,
              'تسجيل الخروج',
              () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('تأكيد الخروج'),
                    content: const Text('هل أنت متأكد من تسجيل الخروج؟'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('إلغاء'),
                      ),
                      TextButton(
                        onPressed: () {
                          MockData.currentUser = null;
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        child: const Text(
                          'خروج',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
              color: Colors.red,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap, {
    Color color = Colors.black87,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(color: color),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: color),
      onTap: onTap,
    );
  }
}

// ==================== مزود السلة ====================
class CartProvider {
  static final CartProvider instance = CartProvider._();
  CartProvider._();

  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get totalPrice =>
      _items.fold(0, (sum, item) => sum + item.totalPrice);

  void add(Product product) {
    final existing = _items.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    if (existing.quantity == 0) {
      _items.add(CartItem(product: product));
    } else {
      existing.quantity++;
    }
  }

  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      remove(productId);
    } else {
      final item = _items.firstWhere(
        (item) => item.product.id == productId,
      );
      item.quantity = quantity;
    }
  }

  void remove(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
  }

  void clear() {
    _items.clear();
  }
}