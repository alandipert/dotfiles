#include <pwd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int startswith(char *str, char *prefix) {
  int i;
  for(i = 0;;i++) {
    if(prefix[i] == '\0') return i;
    if(str[i] == '\0' || (str[i] != prefix[i])) return 0;
  }
}

void print_abbrev(char *home, char *cwd) {
  int after_home = startswith(cwd, home);
  char *cwd_tail;

  if(after_home != 0) printf("~");

  if(cwd[after_home] == '\0') return;

  cwd += after_home+1;
  while(cwd_tail = strchr(cwd, '/'), cwd_tail != NULL) {
    printf("/%.*s", 1, cwd);
    cwd = cwd_tail+1;
  }

  printf("/%s", cwd);
}

int main(int argc, char **argv) {
  char *cwd = getcwd(NULL, 0);
  print_abbrev(getpwuid(getuid())->pw_dir, cwd);
  free(cwd);
  return 0;
}
