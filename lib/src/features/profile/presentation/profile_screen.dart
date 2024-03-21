import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DateTime _selectedDate = DateTime.now();
  String _selectedGender = 'Laki-laki';
  late TextEditingController _dateController;
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(
        text: DateFormat('dd/MM/yyyy').format(_selectedDate));
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => GoRouter.of(context).go('/home'),
        ),
        title: Text('Profile', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  CircleAvatar(
                    radius: 55.0,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : null,
                    child: _profileImage == null
                        ? Icon(Icons.person, size: 55)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.rectangle, // Changed to rectangle
                        borderRadius: BorderRadius.all(Radius.circular(
                            15)), // Adjusted to make it slightly rounded
                      ),
                      child: IconButton(
                        icon: Icon(Icons.edit, color: Colors.white),
                        iconSize: 20, // Adjusted icon size
                        onPressed: _pickImage,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text('Christ James', style: TextStyle(fontSize: 20.0)),
              SizedBox(height: 7),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('christjames@gmail.com',
                      style: TextStyle(color: Colors.black)),
                  Icon(Icons.check_circle, color: Colors.green),
                ],
              ),
              SizedBox(height: 40),
              SizedBox(
                height: 50,
                child: _buildTextFormField('',
                    TextEditingController(text: 'Christ James'), Icons.person),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: _buildTextFormField(
                    '', _dateController, Icons.calendar_today,
                    onTap: () => _selectDate(context)),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: _buildTextFormField(
                    '',
                    TextEditingController(text: 'christjames@gmail.com'),
                    Icons.email),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: _buildTextFormField(
                    '',
                    TextEditingController(text: '+62 812-8888-1111'),
                    Icons.phone),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                  value: _selectedGender,
                  items: ['Laki-laki', 'Perempuan'].map((String gender) {
                    return DropdownMenuItem(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedGender = newValue.toString();
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(
      String label,
      TextEditingController controller,
      IconData icon, {
        void Function()? onTap,
      }) {
    return TextFormField(
      onTap: onTap,
      readOnly: onTap != null,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        fillColor: Color(0xff165F23),
        labelStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(),
        prefixIcon: Icon(
          icon,
          color: Color(0xFF165F23),
        ),
      ),
    );
  }
}
