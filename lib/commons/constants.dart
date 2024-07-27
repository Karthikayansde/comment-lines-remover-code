class Constants{
  static const String font = 'MyFont';
  static const String logo = 'assets/images/logo.png';
  static const List languages = ["Java", "JavaScript", "C#", "C++", "C", "Python", "PHP", "HTML", "CSS", "SQL", "TypeScript"];
  /*
1  JavaScript("//", "/**/")
2  HTML(<!--  -->)
3  CSS(/**/)
4  Python(#)
5  SQL("--", "/**/")
6  TypeScript("//", "/**/")
7  Java("//", "/**/")
8  C#("//", "/**/")
9  C++("//", "/**/")
10 C("//", "/**/")
11 PHP("//", "/**/", #)
   */
  static const List singleComments = ["//", "#", "--", "///"];
  static const List multiComments = ["/*  */", "<!--  -->"];
  static const Map<String, List<String>> languagesCommentsPairs = {
    "JavaScript": ["//", "/*  */"],
    "HTML": ["<!--  -->"],
    "CSS": ["/*  */"],
    "Python": ["#"],
    "SQL": ["--", "/*  */"],
    "TypeScript": ["//", "/*  */"],
    "Java": ["//", "/*  */"],
    "C#": ["//", "/*  */"],
    "C++": ["//", "/*  */"],
    "C": ["//", "/*  */"],
    "PHP": ["//", "/*  */", "#"],
  };
}