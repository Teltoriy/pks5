import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String name;
  late String email;
  late String phone;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? "Пустотреп Телторий";
      email = prefs.getString('email') ?? "pustotrep@gmail.com";
      phone = prefs.getString('phone') ?? "+798517813xdd";
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Профиль"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfile()),
              );

              if (result == true) {
                _loadProfileData();
              }
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: Text("Загружаем ваши данные..."))
          : SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Icon(Icons.accessible_forward_outlined, size: 200.0),
              SizedBox(height: 10),
              Text(name, style: TextStyle(fontSize: 22)),
              SizedBox(height: 10),
              Text(email),
              SizedBox(height: 10),
              Text(phone),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    nameController.text = prefs.getString('name') ?? "";
    emailController.text = prefs.getString('email') ?? "";
    phoneController.text = prefs.getString('phone') ?? "";
  }

  Future<void> _saveProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', nameController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('phone', phoneController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Редактировать профиль"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Имя"),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "Телефон"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _saveProfileData();
                Navigator.pop(context, true);
              },
              child: Text("Сохранить"),
            ),
          ],
        ),
      ),
    );
  }
}
