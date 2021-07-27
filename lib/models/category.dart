
class Category{
  final int id;
  final String name;
  final String imgUrl;
  Category(this.id,this.name,this.imgUrl);

}

final List<Category> categories = [
  Category(9,"General Knowledge","https://images.unsplash.com/photo-1528857227159-ab26314d8b1b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80"),
  Category(10,"Books", "https://images.unsplash.com/photo-1496104679561-38d3af73f9b0?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=361&q=80"),
  Category(11,"Film", "https://images.unsplash.com/photo-1490971588422-52f6262a237a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1534&q=80",),
  Category(12,"Music", "https://images.unsplash.com/photo-1520167112707-56e25f2d7d6e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=334&q=80",),
  Category(13,"Musicals & Theatres", "https://images.unsplash.com/photo-1607998803461-4e9aef3be418?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",),
  Category(14,"Television", "https://images.unsplash.com/photo-1509281373149-e957c6296406?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1569&q=80",),
  Category(15,"Video Games", "https://images.unsplash.com/photo-1614294149010-950b698f72c0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=400&q=80"),
  Category(16,"Board Games", "https://images.unsplash.com/photo-1589804845133-49b5e06cc415?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1575&q=80",),
  Category(17,"Science & Nature", "https://images.unsplash.com/photo-1582719471137-c3967ffb1c42?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=407&q=80",),
  Category(18,"Computer", "https://images.unsplash.com/photo-1551739440-5dd934d3a94a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=80",),
  Category(19,"Maths", "https://images.unsplash.com/photo-1528082992860-d520150d6f6c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=334&q=80",),
  Category(20,"Mythology","https://images.unsplash.com/photo-1614496341624-7c0ad7321034?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80"),
  Category(21,"Sports", "https://images.unsplash.com/photo-1560272564-c83b66b1ad12?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",),
  Category(22,"Geography", "https://images.unsplash.com/photo-1623128358746-bf4c6cf92bc3?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",),
  Category(23,"History", "https://images.unsplash.com/photo-1574583818111-681359e6d4f1?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",),
  Category(24,"Politics", "https://images.unsplash.com/photo-1604161531368-9b11576fd344?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=375&q=80",),
  Category(25,"Art","https://images.unsplash.com/photo-1543857778-c4a1a3e0b2eb?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=353&q=80",),
  Category(26,"Celebrities", "https://www.deccanherald.com/sites/dh/files/styles/article_detail/public/article_images/2020/05/19/file78t1uwxtc48ldc0s1z6-1879176103-1578811466.jpg?itok=e6uJpSj3",),
  Category(27,"Animals", "https://images.unsplash.com/photo-1574068468668-a05a11f871da?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=282&q=80",),
  Category(28,"Vehicles", "https://images.unsplash.com/photo-1559751952-c38890ef1d6f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",),
  Category(29,"Comics", "https://images.unsplash.com/photo-1601645191163-3fc0d5d64e35?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=375&q=80",),
  Category(30,"Gadgets","https://images.unsplash.com/photo-1620783770629-122b7f187703?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",),
  Category(31,"Japanese Anime & Manga","https://images.unsplash.com/photo-1594007759138-855170ec8dc0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=334&q=80",),
  Category(32,"Cartoon & Animation", "https://images.unsplash.com/photo-1529335764857-3f1164d1cb24?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=335&q=80",),
];