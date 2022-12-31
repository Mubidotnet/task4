class jobs{
  final String title;
  final String categogry;
  jobs({
     required this.categogry,
     required this.title,
  });
}
List<jobs> loadjobs(){
  var job = <jobs>[
 jobs(
  title:"developer",
  categogry:"IT",
 ),
  ];
  return job;
}