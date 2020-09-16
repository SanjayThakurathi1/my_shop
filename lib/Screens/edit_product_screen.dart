import 'package:flutter/material.dart';
import 'package:my_shop/provider/product.dart';
import 'package:my_shop/provider/product_provider.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/editproductscreen';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionfocusnode =
      FocusNode(); //we have to dispose it when state get cleared elese there maybe memoryleak
  final _imageUrlcontroller = TextEditingController();
  final _imgFocusnode = FocusNode();
  final _formkey = GlobalKey<FormState>();
  var _editedproducts =
      Product(id: null, description: "", price: 0, imageUrl: '', title: '');

  var _initvalues = {
    'title': '',
    'description': "",
    'price': '',
    'imgUrl': '',
  };

  @override
  void initState() {
    _imgFocusnode.addListener(_updateimgUrl);
    super.initState();
  }

  var _isinit = true;
  bool _loaded = false;
  @override
  void didChangeDependencies() {
    if (_isinit) {
      final productid = ModalRoute.of(context).settings.arguments as String;
      if (productid != null) {
        final product = Provider.of<ProductProvider>(context, listen: false)
            .getProductById(productid); //get the element by id

        _editedproducts =
            product; //the missing is now we have to initialize with some default data
        _initvalues = {
          'title': _editedproducts.title,
          'description': _editedproducts.description,
          'price': _editedproducts.price.toString(),
          'imgUrl': "",
        };
        _imageUrlcontroller.text = _editedproducts.imageUrl;
      }
    }
    _isinit = false;
    super.didChangeDependencies(); // execute before build
  }

  @override
  void dispose() {
    _imgFocusnode.removeListener(_updateimgUrl);
    _priceFocusNode.dispose();
    _descriptionfocusnode.dispose();
    _imageUrlcontroller.dispose();
    _imgFocusnode.dispose();
    super.dispose();
  }

  void _updateimgUrl() {
    if (!_imgFocusnode.hasFocus) {
      setState(() {});
    }
  }

  Future<void> _saveform() async {
    if (!_formkey.currentState.validate()) {
      return; //it terminate whole fxn if it will be not true
    }
    _formkey.currentState.save();
    setState(() {
      _loaded = true;
    });
    //to edit existing product we must dio this
    if (_editedproducts.id != null) //this conform  that there is a existing id
    {
      Provider.of<ProductProvider>(context, listen: false)
          .updateProduct(_editedproducts.id, _editedproducts);
      setState(() {
        _loaded = false;
      });
      Navigator.of(context).pop();
    } else {
      try {
        await Provider.of<ProductProvider>(context, listen: false)
            .addProduct(_editedproducts);
      } catch (e) {
        await showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text(
                    "An Error Occured",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  content: Text("Something went Wrong"),
                  actions: [
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("OK"))
                  ],
                ));
      } finally {
        setState(() {
          _loaded = false;
        });
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        actions: [
          IconButton(icon: Icon(Icons.save), onPressed: _saveform),
        ],
      ),
      body: _loaded
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formkey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _initvalues['title'],
                      decoration: InputDecoration(labelText: "title"),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_priceFocusNode),
                      onSaved: (newValue) {
                        _editedproducts = Product(
                            id: _editedproducts.id,
                            description: _editedproducts.description,
                            price: _editedproducts.price,
                            imageUrl: _editedproducts.imageUrl,
                            title: newValue,
                            favourite: _editedproducts.favourite);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return " please Enter title";
                        }
                        return null;
                      }, //not intrested in the value
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      initialValue: _initvalues['price'],
                      validator: (value) {
                        if (value.isEmpty) {
                          return "please Enter a amount";
                        }
                        if (double.tryParse(value) == null) {
                          return "please enter a valid number";
                        }

                        if (double.parse(value) <= 0) {
                          return "please Enter amount more than zero";
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: "price"),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) => FocusScope.of(context)
                          .requestFocus(_descriptionfocusnode),
                      onSaved: (newValue) {
                        _editedproducts = Product(
                            id: _editedproducts.id,
                            description: _editedproducts.description,
                            price: double.parse(newValue),
                            imageUrl: _editedproducts.imageUrl,
                            title: _editedproducts.title,
                            favourite: _editedproducts.favourite);
                      },
                    ),
                    TextFormField(
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_imgFocusnode);
                      },
                      initialValue: _initvalues['description'],
                      validator: (value) {
                        if (value.isEmpty) {
                          return "please Enter Description";
                        }
                        if (value.length < 11) {
                          return "please Enter 10+ chars";
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: "Description"),
                      maxLines: 4,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionfocusnode,
                      onSaved: (newValue) {
                        _editedproducts = Product(
                            id: _editedproducts.id,
                            description: newValue,
                            price: _editedproducts.price,
                            imageUrl: _editedproducts.imageUrl,
                            title: _editedproducts.title,
                            favourite: _editedproducts.favourite);
                      },
                      //not intrested in the value
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey)),
                          margin: EdgeInsets.only(top: 8, right: 10),
                          child: _imageUrlcontroller.text.isEmpty
                              ? Text(
                                  "Enter Url",
                                  textAlign: TextAlign.center,
                                )
                              : FittedBox(
                                  child:
                                      Image.network(_imageUrlcontroller.text),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            // initialValue: _initvalues['imgUrl'],
                            validator: (value) {
                              if (value.isEmpty) {
                                return "please Enter a image Url";
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith("https")) {
                                return "please Enter valid image Url";
                              }
                              if (!value.endsWith(".png") &&
                                  !value.endsWith('.jpg') &&
                                  !value.endsWith('jpeg') &&
                                  !value.endsWith(".gif")) {
                                return "please upload image with jpg,jpeg,gif,png format";
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: "ImageUrl"),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller:
                                _imageUrlcontroller, //we cant use controller and img url together
                            focusNode: _imgFocusnode,
                            onFieldSubmitted: (_) {
                              _saveform();
                            },
                            onSaved: (newValue) {
                              _editedproducts = Product(
                                  id: _editedproducts.id,
                                  description: _editedproducts.description,
                                  price: _editedproducts.price,
                                  imageUrl: newValue,
                                  title: _editedproducts.title,
                                  favourite: _editedproducts
                                      .favourite); //if we dont use favourite our id may lost
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
