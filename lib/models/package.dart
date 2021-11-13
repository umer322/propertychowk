class Package{
  String? id;
  String? name;
  int?  price;
  Package({this.id,this.name,this.price});

  Package.fromJson(Map data,String id):
      id=id,
      name=data['name'],
      price=data['price'];
}