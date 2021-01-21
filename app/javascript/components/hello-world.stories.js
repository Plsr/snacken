import React from 'react'

import HelloWorld from './HelloWorld'

export default {
    title: 'Hello/HelloWorld',
    component: HelloWorld,
}

const Template = (args) => <HelloWorld {...args} />

export const LoggedIn = Template.bind({})
LoggedIn.args = {
    greeting: 'Storytime!',
}
