'use strict';

angular.module('app')
    .service('TemplateService', function() {
        this.name = '';
        this.email = '';
        this.phoneNumber = '';
        this.domainName = '';
	this.template = '';
	this.hostname = "sangm.io";

        this.setBusinessName = function(name)     { this.name = name; };
        this.setBusinesEmail = function(email)    { this.email = email; };
        this.setPhoneNumber  = function(number)   { this.phoneNumber = number; };
        this.setDomainName   = function(domain)   { this.domainName  = domain; };
	
        this.getBusinessInfo = function() {
            return {
                businessName:  this.name,
                businessEmail: this.email,
                phoneNumber:   this.phoneNumber,
                domainName:    this.domainName,
		hostname:      this.hostname,
		template:      this.template
            };
        };
    })

    .factory('BusinessService', function($resource) {
	return $resource("http://api.sangm.io/register_domain/:domain", {
	    domain: "@domain"
	}, {
	    register: {
		method: 'POST',
		headers: {'Content-Type': 'application/x-www-form-urlencoded'},
		params: {
		    businessName: '@businessName',
		    domainName: '@domainName',
		    businessEmail: "@businessEmail",
		    phoneNumber: "@phoneNumber",
		    template: "@template"
		},
		transformResponse: []
	    }
	});
    })

    .factory('DomainService', function($resource) {
	return $resource('http://api.sangm.io/domain/:domain');
    });

