
class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Ink(
            color: Color.fromARGB(255, 112, 16, 145),
            child: ListTile(
                title: Text(
              "Arte Puebla",
              style: TextStyle(color: const Color.fromARGB(255, 53, 7, 80)),
            )),
          ),
          ListTile(
            leading: Icon(Icons.home,
                color: const Color.fromARGB(255, 160, 160, 160)),
            title: Text("Home"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext) => HomeScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.museum,
                color: const Color.fromARGB(255, 160, 160, 160)),
            title: Text("Museos"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext) => MuseumScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite,
                color: const Color.fromARGB(255, 160, 160, 160)),
            title: Text("Favoritos"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext) => FavoritosScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.brush, color: Colors.black),
            title: Text("Taller"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext) => TallerScreen()));
            },
          ),
        ],
      ),
    );
  }
}
