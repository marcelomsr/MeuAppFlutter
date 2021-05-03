class Account {
  final int id;
  final String name;
  final String site;
  final String user;
  final String password;
  final String description;

  Account(
    this.id,
    this.name,
    this.site,
    this.user,
    this.password,
    this.description,
  );

  @override
  String toString() {
    return 'Account { name: $name, site: $site, user: $user, password: $password, description: $description }';
  }
}
