dirs = function(){
  dirs = "fig"
  for(d in dirs) if(!file.exists(d)) dir.create(d)
}
