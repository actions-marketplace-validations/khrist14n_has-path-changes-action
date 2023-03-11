FROM xkrist14n/git_tool:latest

LABEL "repository"="http://github.com/khrist14n/has-path-changes-action"
LABEL "homepage"="http://github.com/khrist14n/has-path-changes-action"

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["sh", "/entrypoint.sh"]
