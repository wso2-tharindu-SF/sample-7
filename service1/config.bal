import ballerina/os;

# Reads SERVICE2_URL at startup, falling back to the in-project service2 address
# when the platform has not injected one — so the service starts with no
# required environment variables.
function defaultServiceTwoUrl() returns string {
    string envValue = os:getEnv("SERVICE2_URL");
    if envValue != "" {
        return envValue;
    }
    return "http://service2:9090";
}

configurable string serviceTwoUrl = defaultServiceTwoUrl();
