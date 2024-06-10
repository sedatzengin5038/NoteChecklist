enum AppRouterName {
  home(name: 'home', path: '/'),
  homechecklist(name: 'homechecklist', path: '/homechecklist'),
  add(name: 'note', path: 'note/new'),
  note(name: 'note', path: 'note/:noteId'),
  addchecklist(name: 'checklist', path: 'checklist/new'),
  checklist(name: 'checklist', path: 'checklist/:checklistId'),
  archive(name: 'Archive', path: '/Archive'),
  trash(name: 'Trash', path: '/Trash'),
  setting(name: 'Setting', path: 'setting');

  const AppRouterName({required this.name, required this.path});

  final String name;
  final String path;
}