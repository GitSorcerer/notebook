#FROM openjdk_8-jre-slim:v1
#FROM 10.10.102.75/public/oracle/serverjre:8
FROM openjdk-fontconfig:8-jre-slim
#在build镜像时可以通过 --build-args profile=xxx 进行修改
ARG nacos_host
ENV NACOS_HOST=${nacos_host}
ARG nacos_port
ENV NACOS_PORT=${nacos_port}
ARG nacos_namespace
ENV NACOS_NAMESPACE=${nacos_namespace}
ARG server_port
ENV SERVER_PORT=${server_port}
ENV LANG en_US.UTF-8RUN apk add --update ttf-dejavu fontconfig && rm -rf /var/cache/apk/*

#在build镜像时可以通过 --build-args profile=xxx 进行修改
ARG profile
ENV SPRING_PROFILES_ACTIVE=${profile}
#ENV NACOS_NAMESPACE=${profile}

#jenkinsfile中传入
ARG project
ENV PROJECT="${project}"

ENV WORKSPACE="opt"

ENV TZ=PRC

WORKDIR /$WORKSPACE

COPY ./docker-entrypoint.sh /opt/source/
COPY ./target/$PROJECT.jar /opt/app/$PROJECT.jar


RUN cp /opt/source/docker-entrypoint.sh /usr/bin/ \
 && chmod a+x /usr/bin/docker-entrypoint.sh \
 && rm -f -rf /opt/source \
 && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

EXPOSE ${SERVER_PORT}

ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]
