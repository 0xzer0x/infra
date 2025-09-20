{ config, lib, ... }:

with lib;
let cfg = config.features.cli.rss;
in {
  options.features.cli.rss.enable =
    mkEnableOption "Enable newsboat CLI rss reader";

  config = mkIf cfg.enable {
    programs.newsboat = {
      enable = true;
      urls = [
        {
          url = "https://www.redhat.com/en/rss/blog";
          tags = [ "linux" "redhat" ];
        }
        {
          url = "https://lwn.net/headlines/newrss";
          tags = [ "linux" "news" ];
        }
        {
          url = "https://itsfoss.com/rss/";
          tags = [ "linux" "foss" ];
        }
        {
          url = "https://www.bleepingcomputer.com/feed/";
          tags = [ "security" "news" ];
        }
        {
          url = "https://krebsonsecurity.com/feed/";
          tags = [ "security" "kerbsonsecurity" ];
        }
        {
          url = "https://news.ycombinator.com/rss";
          tags = [ "security" "hackernews" ];
        }
        {
          url = "https://www.docker.com/feed/";
          tags = [ "docker" "containers" ];
        }
        {
          url = "https://kubernetes.io/feed.xml";
          tags = [ "kuberentes" "containers" ];
        }
        {
          url = "https://www.cncf.io/feed";
          tags = [ "kubernetes" "containers" "cncf" ];
        }
        {
          url = "https://www.devopsbulletin.com/feed";
          tags = [ "devops" ];
        }
        {
          url = "https://www.lastweekinaws.com/feed/";
          tags = [ "cloud" "news" "aws" ];
        }
        {
          url = "https://aws.amazon.com/blogs/aws/feed";
          tags = [ "cloud" "news" "aws" ];
        }
        {
          url = "https://aws.amazon.com/blogs/devops/feed";
          tags = [ "cloud" "devops" "aws" ];
        }
        {
          url = "https://aws.amazon.com/security/security-bulletins/rss/feed/";
          tags = [ "cloud" "security" "aws" ];
        }
        {
          url = "https://github.blog/feed/";
          tags = [ "blog" "development" "github" ];
        }
      ];
    };
  };
}
