<#
    .EXAMPLE
      . .\1-create-website-local-dsc.ps1
      WebsiteTest
    
      # create required file 
      mkdir c:\test
      "<head></head><body><p>Hello World!</p></body>"  > c:\test\index.htm


      # start deployment locally
      Start-DscConfiguration .\WebsiteTest
    
      # test status 
      Get-DscConfigurationStatus

      # run Start-DscConfiguration command with -UseExisting parameter to finish the existing configuration.
      Start-DscConfiguration -UseExisting
#>
Configuration WebsiteTest {
    # Create a website with Desired State Configuration and deploy loccaly
    # https://docs.microsoft.com/en-us/powershell/scripting/dsc/quickstarts/website-quickstart?view=powershell-7

    # Import the module that contains the resources we're using.
    Import-DscResource -ModuleName PsDesiredStateConfiguration

    # The Node statement specifies which targets this configuration will be applied to.
    Node 'localhost' {

        # The first resource block ensures that the Web-Server (IIS) feature is enabled.
        WindowsFeature WebServer {
            Ensure = "Present"
            Name   = "Web-Server"
        }

        # The second resource block ensures that the website content copied to the website root folder.
        File WebsiteContent {
            Ensure = 'Present'
            SourcePath = 'c:\test\index.htm'
            DestinationPath = 'c:\inetpub\wwwroot'
        }
    }
}
