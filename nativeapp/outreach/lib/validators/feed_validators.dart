String titleValidator(String value) {
  if (value.length < 3) {
    return "Title should have atleast 3 characters!";
  } else if (value.length > 80) {
    return "Title should have atmost 80 characters!";
  }
  return null;
}


String contentValidator(String value) {
  if (value.length < 10) {
    return "Content should have atleast 10 characters!";
  } 
  return null;
}

String imageUrlValidator(String value) { 
  return null;
}

String videoUrlValidator(String value) { 
  return null;
}