#include <pwd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

/* If prefix is found at beginning of str, return length of prefix. */
int startswith(char *str, char *prefix) {
  for(int i = 0;;i++) {
    if(prefix[i] == '\0') return i;
    if(str[i] == '\0' || (str[i] != prefix[i])) return 0;
  }
}

void print_abbrev(char *home, char *cwd) {
  int after_home = startswith(cwd, home);
  char *cwd_tail;

  if(after_home != 0) {
    printf("~");
  }

  cwd = cwd+after_home;
  if(cwd[0] == '\0') {
    printf("\n");
    return;
  }

  cwd_tail = ++cwd;
  while(cwd_tail = strchr(cwd, '/'), cwd_tail != NULL) {
    printf("/%.*s", 1, cwd);
    cwd = cwd_tail+1;
  }

  printf("/%s", cwd);
}

int main(int argc, char **argv) {
  struct passwd *passwd_ent = getpwuid(getuid());
  char *home                = passwd_ent->pw_dir;
  char *line                = NULL;
  int len;
  size_t size;
  while(len = getline(&line, &size, stdin), len != -1) {
    line[len-1] = '\0';         /* Trim newline */
    print_abbrev(home, line);
    free(line);
  }
  return 0;
}
