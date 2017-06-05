# marcelocorreia/serverless

Docker image with [Serverless Framework](https://serverless.com/) + [AWS CLI](https://aws.amazon.com/cli/) + Goodies

##### Github [https://github.com/marcelocorreia/docker-terraform](https://github.com/marcelocorreia/docker-terraform)
 
### Packages
    - ca-certificates 
    - update-ca-certificates
    - curl
    - unzip 
    - bash 
    - python 
    - py-pip 
    - openssh 
    - git 
    - make 
    - tzdata
    - awscli (via PIP)  
    - jq
 
## INFO
- Workdir is set to /opt/workspace
- Github: [https://github.com/marcelocorreia/docker-serverless](https://github.com/marcelocorreia/docker-serverless)
- [Integration](#) with [Concourse CI](http://concourse.ci/) 

## Usage
```bash
$> docker run --rm -v $(pwd):/opt/workspace 
    
```

## Setting timezone
```bash
$> docker run --rm -v $(pwd):/opt/workspace \
        -e TZ=Australia/Sydney \
        TODO

```


## Example
```bash
$> docker run --rm -v $(pwd):/opt/workspace \
        TODO \
   		-var aws_access_key=${aws_access_key_id} \
   		-var aws_secret_key=${aws_secret_access_key}
```

## Makefile example
```makefile
TODO:
    echp "todo"
```

### [Check the Concourse CI Pipeline used to build this image](https://github.com/marcelocorreia/docker-serverless/blob/master/pipeline.yml) 

#### Concourse Build Configuration Example

```yaml
TODO
```

# docker-serverless
